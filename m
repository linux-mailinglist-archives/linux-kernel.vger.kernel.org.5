Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07540806C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377696AbjLFKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377516AbjLFKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C019D41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6AAC433CD;
        Wed,  6 Dec 2023 10:46:07 +0000 (UTC)
Message-ID: <a44a38ed-e9fe-4a62-a376-1689a2f5f037@xs4all.nl>
Date:   Wed, 6 Dec 2023 11:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] media: visl: Add a stable_output parameter
Content-Language: en-US, nl
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231123200451.148097-1-detlev.casanova@collabora.com>
 <20231123200451.148097-3-detlev.casanova@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231123200451.148097-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 20:57, Detlev Casanova wrote:
> This parameter is used to ensure that for a given input, the output
> frames are always identical so that it can be compared against
> a reference in automatic tests.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/media/test-drivers/visl/visl-core.c |   5 +
>  drivers/media/test-drivers/visl/visl-dec.c  | 256 ++++++++++++--------
>  drivers/media/test-drivers/visl/visl.h      |   1 +
>  3 files changed, 166 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
> index ef89eead6671..a9c060104932 100644
> --- a/drivers/media/test-drivers/visl/visl-core.c
> +++ b/drivers/media/test-drivers/visl/visl-core.c
> @@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0444);
>  MODULE_PARM_DESC(bitstream_trace_nframes,
>  		 " the number of frames to dump the bitstream through debugfs");
>  
> +bool stable_output = true;
> +module_param(stable_output, bool, 0644);
> +MODULE_PARM_DESC(stable_output,
> +		 " only write stable data for a given input on the output frames");
> +

Seeing it like this I am still not happy with this.

So by default the data is stable (good!). But while disabling this option does
indeed make the data unstable, the real reason why you want to do that is to get
the addition information.

So this module name is just weird.

It is more a TPG info level that you provide here. Perhaps "tpg_verbose" is a better
name?

>  static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
>  	{
>  		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index 318d675e5668..a6c878f0813a 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -52,11 +52,17 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  	case VISL_CODEC_FWHT: {
>  		struct vb2_buffer *vb2_buf;
>  
> -		vb2_buf = vb2_find_buffer(cap_q, run->fwht.params->backward_ref_ts);
> +		if (!stable_output) {

That will also change this condition to 'if (tpg_verbose)' which is better then
negating a boolean.

> +			vb2_buf = vb2_find_buffer(cap_q, run->fwht.params->backward_ref_ts);
> +
> +			scnprintf(buf, buflen, "backwards_ref_ts: %lld, vb2_idx: %d",
> +				  run->fwht.params->backward_ref_ts,
> +				  vb2_buf ? vb2_buf->index : -1);
> +		} else {
> +			scnprintf(buf, buflen, "backwards_ref_ts: %lld",
> +				  run->fwht.params->backward_ref_ts);
> +		}
>  
> -		scnprintf(buf, buflen, "backwards_ref_ts: %lld, vb2_idx: %d",
> -			  run->fwht.params->backward_ref_ts,
> -			  vb2_buf ? vb2_buf->index : -1);
>  		break;
>  	}
>  
> @@ -64,16 +70,25 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  		struct vb2_buffer *b_ref;
>  		struct vb2_buffer *f_ref;
>  
> -		b_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->backward_ref_ts);
> -		f_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->forward_ref_ts);
> +		if (!stable_output) {
> +			b_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->backward_ref_ts);
> +			f_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->forward_ref_ts);
> +
> +			scnprintf(buf, buflen,
> +				  "backward_ref_ts: %llu, vb2_idx: %d\n"
> +				  "forward_ref_ts: %llu, vb2_idx: %d\n",
> +				  run->mpeg2.pic->backward_ref_ts,
> +				  b_ref ? b_ref->index : -1,
> +				  run->mpeg2.pic->forward_ref_ts,
> +				  f_ref ? f_ref->index : -1);
> +		} else {
> +			scnprintf(buf, buflen,
> +				  "backward_ref_ts: %llu\n"
> +				  "forward_ref_ts: %llu\n",
> +				  run->mpeg2.pic->backward_ref_ts,
> +				  run->mpeg2.pic->forward_ref_ts);
>  
> -		scnprintf(buf, buflen,
> -			  "backward_ref_ts: %llu, vb2_idx: %d\n"
> -			  "forward_ref_ts: %llu, vb2_idx: %d\n",
> -			  run->mpeg2.pic->backward_ref_ts,
> -			  b_ref ? b_ref->index : -1,
> -			  run->mpeg2.pic->forward_ref_ts,
> -			  f_ref ? f_ref->index : -1);
> +		}

I'm a bit unhappy about the amount of code churn here.

A lot of the time it prints a timestamp + buffer index. Perhaps a small
helper function will help:

		visl_print_ts_idx(&buf, &buflen, "backward_ref_ts", ts, b_ref);

That helper only prints the vb2_idx if enabled, and it can also omit it
if the vb2_buffer pointer == NULL.

>  		break;
>  	}
>  
> @@ -82,20 +97,30 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  		struct vb2_buffer *golden;
>  		struct vb2_buffer *alt;
>  
> -		last = vb2_find_buffer(cap_q, run->vp8.frame->last_frame_ts);
> -		golden = vb2_find_buffer(cap_q, run->vp8.frame->golden_frame_ts);
> -		alt = vb2_find_buffer(cap_q, run->vp8.frame->alt_frame_ts);
> -
> -		scnprintf(buf, buflen,
> -			  "last_ref_ts: %llu, vb2_idx: %d\n"
> -			  "golden_ref_ts: %llu, vb2_idx: %d\n"
> -			  "alt_ref_ts: %llu, vb2_idx: %d\n",
> -			  run->vp8.frame->last_frame_ts,
> -			  last ? last->index : -1,
> -			  run->vp8.frame->golden_frame_ts,
> -			  golden ? golden->index : -1,
> -			  run->vp8.frame->alt_frame_ts,
> -			  alt ? alt->index : -1);
> +		if (!stable_output) {
> +			last = vb2_find_buffer(cap_q, run->vp8.frame->last_frame_ts);
> +			golden = vb2_find_buffer(cap_q, run->vp8.frame->golden_frame_ts);
> +			alt = vb2_find_buffer(cap_q, run->vp8.frame->alt_frame_ts);
> +
> +			scnprintf(buf, buflen,
> +				  "last_ref_ts: %llu, vb2_idx: %d\n"
> +				  "golden_ref_ts: %llu, vb2_idx: %d\n"
> +				  "alt_ref_ts: %llu, vb2_idx: %d\n",
> +				  run->vp8.frame->last_frame_ts,
> +				  last ? last->index : -1,
> +				  run->vp8.frame->golden_frame_ts,
> +				  golden ? golden->index : -1,
> +				  run->vp8.frame->alt_frame_ts,
> +				  alt ? alt->index : -1);
> +		} else {
> +			scnprintf(buf, buflen,
> +				  "last_ref_ts: %llu\n"
> +				  "golden_ref_ts: %llu\n"
> +				  "alt_ref_ts: %llu\n",
> +				  run->vp8.frame->last_frame_ts,
> +				  run->vp8.frame->golden_frame_ts,
> +				  run->vp8.frame->alt_frame_ts);
> +		}
>  		break;
>  	}
>  
> @@ -104,32 +129,49 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  		struct vb2_buffer *golden;
>  		struct vb2_buffer *alt;
>  
> -		last = vb2_find_buffer(cap_q, run->vp9.frame->last_frame_ts);
> -		golden = vb2_find_buffer(cap_q, run->vp9.frame->golden_frame_ts);
> -		alt = vb2_find_buffer(cap_q, run->vp9.frame->alt_frame_ts);
> -
> -		scnprintf(buf, buflen,
> -			  "last_ref_ts: %llu, vb2_idx: %d\n"
> -			  "golden_ref_ts: %llu, vb2_idx: %d\n"
> -			  "alt_ref_ts: %llu, vb2_idx: %d\n",
> -			  run->vp9.frame->last_frame_ts,
> -			  last ? last->index : -1,
> -			  run->vp9.frame->golden_frame_ts,
> -			  golden ? golden->index : -1,
> -			  run->vp9.frame->alt_frame_ts,
> -			  alt ? alt->index : -1);
> +		if (!stable_output) {
> +			last = vb2_find_buffer(cap_q, run->vp9.frame->last_frame_ts);
> +			golden = vb2_find_buffer(cap_q, run->vp9.frame->golden_frame_ts);
> +			alt = vb2_find_buffer(cap_q, run->vp9.frame->alt_frame_ts);
> +
> +			scnprintf(buf, buflen,
> +				  "last_ref_ts: %llu, vb2_idx: %d\n"
> +				  "golden_ref_ts: %llu, vb2_idx: %d\n"
> +				  "alt_ref_ts: %llu, vb2_idx: %d\n",
> +				  run->vp9.frame->last_frame_ts,
> +				  last ? last->index : -1,
> +				  run->vp9.frame->golden_frame_ts,
> +				  golden ? golden->index : -1,
> +				  run->vp9.frame->alt_frame_ts,
> +				  alt ? alt->index : -1);
> +		} else {
> +			scnprintf(buf, buflen,
> +				  "last_ref_ts: %llu\n"
> +				  "golden_ref_ts: %llu\n"
> +				  "alt_ref_ts: %llu\n",
> +				  run->vp9.frame->last_frame_ts,
> +				  run->vp9.frame->golden_frame_ts,
> +				  run->vp9.frame->alt_frame_ts);
> +		}
>  		break;
>  	}
>  
>  	case VISL_CODEC_H264: {
>  		char entry[] = "dpb[%d]:%u, vb2_index: %d\n";
> +		char entry_stable[] = "dpb[%d]:%u\n";
>  		struct vb2_buffer *vb2_buf;
>  
>  		for (i = 0; i < ARRAY_SIZE(run->h264.dpram->dpb); i++) {
> -			vb2_buf = vb2_find_buffer(cap_q, run->h264.dpram->dpb[i].reference_ts);
> -			len = scnprintf(buf, buflen, entry, i,
> -					run->h264.dpram->dpb[i].reference_ts,
> -					vb2_buf ? vb2_buf->index : -1);
> +			if (!stable_output) {
> +				vb2_buf = vb2_find_buffer(cap_q,
> +							  run->h264.dpram->dpb[i].reference_ts);
> +				len = scnprintf(buf, buflen, entry, i,
> +						run->h264.dpram->dpb[i].reference_ts,
> +						vb2_buf ? vb2_buf->index : -1);
> +			} else {
> +				len = scnprintf(buf, buflen, entry_stable, i,
> +						run->h264.dpram->dpb[i].reference_ts);
> +			}
>  			buf += len;
>  			buflen -= len;
>  		}
> @@ -139,13 +181,20 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  
>  	case VISL_CODEC_HEVC: {
>  		char entry[] = "dpb[%d]:%u, vb2_index: %d\n";
> +		char entry_stable[] = "dpb[%d]:%u\n";
>  		struct vb2_buffer *vb2_buf;
>  
>  		for (i = 0; i < ARRAY_SIZE(run->hevc.dpram->dpb); i++) {
> -			vb2_buf = vb2_find_buffer(cap_q, run->hevc.dpram->dpb[i].timestamp);
> -			len = scnprintf(buf, buflen, entry, i,
> -					run->hevc.dpram->dpb[i].timestamp,
> -					vb2_buf ? vb2_buf->index : -1);
> +			if (!stable_output) {
> +				vb2_buf = vb2_find_buffer(cap_q, run->hevc.dpram->dpb[i].timestamp);
> +				len = scnprintf(buf, buflen, entry, i,
> +						run->hevc.dpram->dpb[i].timestamp,
> +						vb2_buf ? vb2_buf->index : -1);
> +			} else {
> +				len = scnprintf(buf, buflen, entry_stable, i,
> +						run->hevc.dpram->dpb[i].timestamp);
> +			}
> +
>  			buf += len;
>  			buflen -= len;
>  		}
> @@ -197,19 +246,30 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
>  {
>  	u32 stream_ms;
>  
> -	stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
> -
> -	scnprintf(buf, bufsz,
> -		  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
> -		  (stream_ms / (60 * 60 * 1000)) % 24,
> -		  (stream_ms / (60 * 1000)) % 60,
> -		  (stream_ms / 1000) % 60,
> -		  stream_ms % 1000,
> -		  run->dst->sequence,
> -		  run->dst->vb2_buf.timestamp,
> -		  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> -		  (run->dst->field == V4L2_FIELD_TOP ?
> -		  " top" : " bottom") : "none");
> +	if (!stable_output) {
> +		stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
> +
> +		scnprintf(buf, bufsz,
> +			  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
> +			  (stream_ms / (60 * 60 * 1000)) % 24,
> +			  (stream_ms / (60 * 1000)) % 60,
> +			  (stream_ms / 1000) % 60,
> +			  stream_ms % 1000,

The only difference here is the stream time, so just do that in a separate
scnprintf if tpg_verbose is set.

> +			  run->dst->sequence,
> +			  run->dst->vb2_buf.timestamp,
> +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> +			  (run->dst->field == V4L2_FIELD_TOP ?
> +			  " top" : " bottom") : "none");
> +	} else {
> +		scnprintf(buf, bufsz,
> +			  "sequence:%u timestamp:%lld field:%s",
> +			  run->dst->sequence,
> +			  run->dst->vb2_buf.timestamp,
> +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> +			  (run->dst->field == V4L2_FIELD_TOP ?
> +			  " top" : " bottom") : "none");
> +
> +	}
>  }
>  
>  static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
> @@ -280,28 +340,30 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  	}
>  
> -	line++;
> -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> -	scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> +	if (!stable_output) {
> +		line++;
> +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> +		scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  
> -	len = 0;
> -	for (i = 0; i < out_q->num_buffers; i++) {
> -		char entry[] = "index: %u, state: %s, request_fd: %d, ";
> -		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
> +		len = 0;
> +		for (i = 0; i < out_q->num_buffers; i++) {
> +			char entry[] = "index: %u, state: %s, request_fd: %d, ";
> +			u32 old_len = len;
> +			char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
>  
> -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> -				 entry, i, q_status,
> -				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
> +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> +					 entry, i, q_status,
> +					 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
>  
> -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> -					   &buf[len],
> -					   TPG_STR_BUF_SZ - len);
> +			len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> +						   &buf[len],
> +						   TPG_STR_BUF_SZ - len);
>  
> -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> +			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +		}
>  	}
>  
>  	line++;
> @@ -333,25 +395,27 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  	}
>  
> -	line++;
> -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> -	scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
> -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> +	if (!stable_output) {
> +		line++;
> +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> +		scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
> +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  
> -	len = 0;
> -	for (i = 0; i < cap_q->num_buffers; i++) {
> -		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
> +		len = 0;
> +		for (i = 0; i < cap_q->num_buffers; i++) {
> +			u32 old_len = len;
> +			char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
>  
> -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> -				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> -				 cap_q->bufs[i]->index, q_status,
> -				 cap_q->bufs[i]->timestamp,
> -				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
> +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> +					 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> +					 cap_q->bufs[i]->index, q_status,
> +					 cap_q->bufs[i]->timestamp,
> +					 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
>  
> -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> +			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
> index 31639f2e593d..5a81b493f121 100644
> --- a/drivers/media/test-drivers/visl/visl.h
> +++ b/drivers/media/test-drivers/visl/visl.h
> @@ -85,6 +85,7 @@ extern unsigned int visl_dprintk_nframes;
>  extern bool keep_bitstream_buffers;
>  extern int bitstream_trace_frame_start;
>  extern unsigned int bitstream_trace_nframes;
> +extern bool stable_output;
>  
>  #define frame_dprintk(dev, current, fmt, arg...) \
>  	do { \

Regards,

	Hans
