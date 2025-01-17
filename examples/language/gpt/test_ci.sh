pip install -r requirements.txt

# distplan in ["colossalai", "zero1", "zero2", "torch_ddp", "torch_zero"]
export DISTPAN="colossalai"

# The following options only valid when DISTPAN="colossalai"
export TPDEGREE=2
export GPUNUM=4
export PLACEMENT='cpu'
export USE_SHARD_INIT=False
export BATCH_SIZE=8
export MODEL_TYPE="gpt2_medium"


mkdir -p logs
torchrun --standalone --nproc_per_node=${GPUNUM} train_gpt_demo.py --tp_degree=${TPDEGREE} --model_type=${MODEL_TYPE} --batch_size=${BATCH_SIZE} --placement ${PLACEMENT} --shardinit ${USE_SHARD_INIT} --distplan ${DISTPAN} 2>&1 | tee ./logs/${MODEL_TYPE}_${DISTPAN}_gpu_${GPUNUM}_bs_${BATCH_SIZE}_tp_${TPDEGREE}.log
