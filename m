Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80E806AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjLFJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377256AbjLFJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:45:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069DD1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:45:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F1FC433C8;
        Wed,  6 Dec 2023 09:45:42 +0000 (UTC)
Message-ID: <8b293736-972c-48ce-9b13-6b003dafb62e@xs4all.nl>
Date:   Wed, 6 Dec 2023 10:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] media: visl,vidtv: Set parameters permissions to
 0444
Content-Language: en-US, nl
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231123200451.148097-1-detlev.casanova@collabora.com>
 <20231123200451.148097-2-detlev.casanova@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231123200451.148097-2-detlev.casanova@collabora.com>
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
> This avoids confusion with default values and lets userspace
> programs get the modules parameters values at run time.
> 
> This can be useful when setting up a test suite.

You missed a few more:

$ git grep "module_param.*, 0)" drivers/media/test-drivers/
drivers/media/test-drivers/vidtv/vidtv_bridge.c:module_param_array(vidtv_valid_dvb_t_freqs, uint, NULL, 0);
drivers/media/test-drivers/vidtv/vidtv_bridge.c:module_param_array(vidtv_valid_dvb_c_freqs, uint, NULL, 0);
drivers/media/test-drivers/vidtv/vidtv_bridge.c:module_param_array(vidtv_valid_dvb_s_freqs, uint, NULL, 0);

Regards,

	Hans

> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../media/test-drivers/vidtv/vidtv_bridge.c   | 20 +++++++++----------
>  drivers/media/test-drivers/visl/visl-core.c   | 10 +++++-----
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
> index 8b04e12af286..5dd7b1b4f7f1 100644
> --- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
> +++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
> @@ -45,21 +45,21 @@
>  #define LNB_HIGH_FREQ		10600000	/* transition frequency */
>  
>  static unsigned int drop_tslock_prob_on_low_snr;
> -module_param(drop_tslock_prob_on_low_snr, uint, 0);
> +module_param(drop_tslock_prob_on_low_snr, uint, 0444);
>  MODULE_PARM_DESC(drop_tslock_prob_on_low_snr,
>  		 "Probability of losing the TS lock if the signal quality is bad");
>  
>  static unsigned int recover_tslock_prob_on_good_snr;
> -module_param(recover_tslock_prob_on_good_snr, uint, 0);
> +module_param(recover_tslock_prob_on_good_snr, uint, 0444);
>  MODULE_PARM_DESC(recover_tslock_prob_on_good_snr,
>  		 "Probability recovering the TS lock when the signal improves");
>  
>  static unsigned int mock_power_up_delay_msec;
> -module_param(mock_power_up_delay_msec, uint, 0);
> +module_param(mock_power_up_delay_msec, uint, 0444);
>  MODULE_PARM_DESC(mock_power_up_delay_msec, "Simulate a power up delay");
>  
>  static unsigned int mock_tune_delay_msec;
> -module_param(mock_tune_delay_msec, uint, 0);
> +module_param(mock_tune_delay_msec, uint, 0444);
>  MODULE_PARM_DESC(mock_tune_delay_msec, "Simulate a tune delay");
>  
>  static unsigned int vidtv_valid_dvb_t_freqs[NUM_VALID_TUNER_FREQS] = {
> @@ -86,7 +86,7 @@ MODULE_PARM_DESC(vidtv_valid_dvb_s_freqs,
>  		 "Valid DVB-S/S2 frequencies to simulate at Ku-Band, in kHz");
>  
>  static unsigned int max_frequency_shift_hz;
> -module_param(max_frequency_shift_hz, uint, 0);
> +module_param(max_frequency_shift_hz, uint, 0444);
>  MODULE_PARM_DESC(max_frequency_shift_hz,
>  		 "Maximum shift in HZ allowed when tuning in a channel");
>  
> @@ -96,24 +96,24 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nums);
>   * Influences the signal acquisition time. See ISO/IEC 13818-1 : 2000. p. 113.
>   */
>  static unsigned int si_period_msec = 40;
> -module_param(si_period_msec, uint, 0);
> +module_param(si_period_msec, uint, 0444);
>  MODULE_PARM_DESC(si_period_msec, "How often to send SI packets. Default: 40ms");
>  
>  static unsigned int pcr_period_msec = 40;
> -module_param(pcr_period_msec, uint, 0);
> +module_param(pcr_period_msec, uint, 0444);
>  MODULE_PARM_DESC(pcr_period_msec,
>  		 "How often to send PCR packets. Default: 40ms");
>  
>  static unsigned int mux_rate_kbytes_sec = 4096;
> -module_param(mux_rate_kbytes_sec, uint, 0);
> +module_param(mux_rate_kbytes_sec, uint, 0444);
>  MODULE_PARM_DESC(mux_rate_kbytes_sec, "Mux rate: will pad stream if below");
>  
>  static unsigned int pcr_pid = 0x200;
> -module_param(pcr_pid, uint, 0);
> +module_param(pcr_pid, uint, 0444);
>  MODULE_PARM_DESC(pcr_pid, "PCR PID for all channels: defaults to 0x200");
>  
>  static unsigned int mux_buf_sz_pkts;
> -module_param(mux_buf_sz_pkts, uint, 0);
> +module_param(mux_buf_sz_pkts, uint, 0444);
>  MODULE_PARM_DESC(mux_buf_sz_pkts,
>  		 "Size for the internal mux buffer in multiples of 188 bytes");
>  
> diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
> index 9970dc739ca5..ef89eead6671 100644
> --- a/drivers/media/test-drivers/visl/visl-core.c
> +++ b/drivers/media/test-drivers/visl/visl-core.c
> @@ -64,27 +64,27 @@ MODULE_PARM_DESC(visl_transtime_ms, " simulated process time in milliseconds.");
>   * particular number of frames
>   */
>  int visl_dprintk_frame_start = -1;
> -module_param(visl_dprintk_frame_start, int, 0);
> +module_param(visl_dprintk_frame_start, int, 0444);
>  MODULE_PARM_DESC(visl_dprintk_frame_start,
>  		 " a frame number to start tracing with dprintk");
>  
>  unsigned int visl_dprintk_nframes;
> -module_param(visl_dprintk_nframes, uint, 0);
> +module_param(visl_dprintk_nframes, uint, 0444);
>  MODULE_PARM_DESC(visl_dprintk_nframes,
>  		 " the number of frames to trace with dprintk");
>  
>  bool keep_bitstream_buffers;
> -module_param(keep_bitstream_buffers, bool, false);
> +module_param(keep_bitstream_buffers, bool, 0444);
>  MODULE_PARM_DESC(keep_bitstream_buffers,
>  		 " keep bitstream buffers in debugfs after streaming is stopped");
>  
>  int bitstream_trace_frame_start = -1;
> -module_param(bitstream_trace_frame_start, int, 0);
> +module_param(bitstream_trace_frame_start, int, 0444);
>  MODULE_PARM_DESC(bitstream_trace_frame_start,
>  		 " a frame number to start dumping the bitstream through debugfs");
>  
>  unsigned int bitstream_trace_nframes;
> -module_param(bitstream_trace_nframes, uint, 0);
> +module_param(bitstream_trace_nframes, uint, 0444);
>  MODULE_PARM_DESC(bitstream_trace_nframes,
>  		 " the number of frames to dump the bitstream through debugfs");
>  

