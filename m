Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED140771F32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHGLDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjHGLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C319B9;
        Mon,  7 Aug 2023 04:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6733617D0;
        Mon,  7 Aug 2023 11:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F99C433C7;
        Mon,  7 Aug 2023 11:02:52 +0000 (UTC)
Message-ID: <f4108800-8a4d-910b-7b22-6b4a4f4f5302@xs4all.nl>
Date:   Mon, 7 Aug 2023 13:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] [media] dvb-frontends: add missing spaces before ','
Content-Language: en-US, nl
To:     sunran001@208suo.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720023552.1070-1-xujianghui@cdjrlc.com>
 <9bf6cfcbeb9a0854fdb2a29d74885725@208suo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <9bf6cfcbeb9a0854fdb2a29d74885725@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran Sun,

On 20/07/2023 04:37, sunran001@208suo.com wrote:
> Add missing spaces to clear checkpatch errors.
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>

The patch in patchwork is corrupt:

https://patchwork.linuxtv.org/project/linux-media/patch/9bf6cfcbeb9a0854fdb2a29d74885725@208suo.com/

Probably line wrapping issues. Please check your mailer settings!

Regards,

	Hans

> ---
>  drivers/media/dvb-frontends/dib3000mc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/dib3000mc.h b/drivers/media/dvb-frontends/dib3000mc.h
> index 5ed3d9147f8b..b837e107881e 100644
> --- a/drivers/media/dvb-frontends/dib3000mc.h
> +++ b/drivers/media/dvb-frontends/dib3000mc.h
> @@ -73,7 +73,7 @@ struct i2c_adapter *dib3000mc_get_tuner_i2c_master(struct dvb_frontend *demod,
>  }
>  #endif // CONFIG_DVB_DIB3000MC
> 
> -extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, int pid,int onoff);
> +extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, int pid, int onoff);
>  extern int dib3000mc_pid_parse(struct dvb_frontend *fe, int onoff);
> 
>  extern void dib3000mc_set_config(struct dvb_frontend *, struct dib3000mc_config *);

