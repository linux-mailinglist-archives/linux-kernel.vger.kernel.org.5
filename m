Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1645771F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHGLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHGLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772783;
        Mon,  7 Aug 2023 04:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0080617D4;
        Mon,  7 Aug 2023 11:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A7BC433C7;
        Mon,  7 Aug 2023 11:04:45 +0000 (UTC)
Message-ID: <02005fdd-b0a8-291b-0cab-4c0b3b73734d@xs4all.nl>
Date:   Mon, 7 Aug 2023 13:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: dvb-frontends: add missing spaces before '*' and
 remove spaces after '*'
Content-Language: en-US, nl
To:     sunran001@208suo.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720024545.1230-1-xujianghui@cdjrlc.com>
 <1e9b311ce35bc4a115e4a171a565e415@208suo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1e9b311ce35bc4a115e4a171a565e415@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,PDS_BTC_ID,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 04:47, sunran001@208suo.com wrote:
> Add missing spaces to clear checkpatch errors.
> 
> ERROR: "foo* bar" should be "foo *bar"
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>

Also corrupt:

https://patchwork.linuxtv.org/project/linux-media/patch/1e9b311ce35bc4a115e4a171a565e415@208suo.com/

Same issue.

Regards,

	Hans

> ---
>  drivers/media/dvb-frontends/ds3000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/ds3000.c b/drivers/media/dvb-frontends/ds3000.c
> index 20fcf31af165..ca40234a28fa 100644
> --- a/drivers/media/dvb-frontends/ds3000.c
> +++ b/drivers/media/dvb-frontends/ds3000.c
> @@ -456,7 +456,7 @@ static int ds3000_read_status(struct dvb_frontend *fe, enum fe_status *status)
>  }
> 
>  /* read DS3000 BER value */
> -static int ds3000_read_ber(struct dvb_frontend *fe, u32* ber)
> +static int ds3000_read_ber(struct dvb_frontend *fe, u32 *ber)
>  {
>      struct ds3000_state *state = fe->demodulator_priv;
>      struct dtv_frontend_properties *c = &fe->dtv_property_cache;

