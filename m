Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6579415F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbjIFQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjIFQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:25:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53411997
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:25:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9823C433C8;
        Wed,  6 Sep 2023 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694017515;
        bh=Aq4mT0Otg/RqtdkGVBJyVVyZVVYAD1eqMhWaJ0s6hJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOm9d4hsD3xJf8mefKypKDyA8Hs96CQZyuxFP8LZ883axwlvVZOqVGK+XekoSus6N
         CpbBYzMsIEpEuK3WZXhcePc4d5ZIDYehkLiJn4XlEYbhlVPeWM6fk5MGm5yX+dayE8
         RNgG4asz9+f4vMiA193o/ElzEazHW6v/FPiUChmU=
Date:   Wed, 6 Sep 2023 17:25:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: array names updated as per coding
 guidelines
Message-ID: <2023090644-rectal-stunner-e647@gregkh>
References: <ZPhyl29tTHn77/hd@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhyl29tTHn77/hd@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 06:07:43PM +0530, Pavan Bobba wrote:
> Below array names updated as per coding guidelines:
> 
>    1.byVT3253B0_AGC4_RFMD2959
>    2.byVT3253B0_AIROHA2230
>    3.byVT3253B0_UW2451
>    4.byVT3253B0_AGC
> 
>    Conversions performed:
>    a.type encoding info dropped from names
>    b.names replaced by snakecase
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 32 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 696d4dd03aa2..55224918794b 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -761,7 +761,7 @@ static const unsigned char vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
>  #define CB_VT3253B0_AGC_FOR_RFMD2959 195
>  /* For RFMD2959 */
>  static
> -unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
> +unsigned char vt3253b0_agc4_rfmd2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
>  	{0xF0, 0x00},
>  	{0xF1, 0x3E},
>  	{0xF0, 0x80},
> @@ -962,7 +962,7 @@ unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
>  #define CB_VT3253B0_INIT_FOR_AIROHA2230 256
>  /* For AIROHA */
>  static
> -unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
> +unsigned char vt3253b0_airoha2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
>  	{0x00, 0x31},
>  	{0x01, 0x00},
>  	{0x02, 0x00},
> @@ -1223,7 +1223,7 @@ unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
>  
>  #define CB_VT3253B0_INIT_FOR_UW2451 256
>  /* For UW2451 */
> -static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
> +static unsigned char vt3253b0_uw2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
>  	{0x00, 0x31},
>  	{0x01, 0x00},
>  	{0x02, 0x00},
> @@ -1484,7 +1484,7 @@ static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
>  
>  #define CB_VT3253B0_AGC 193
>  /* For AIROHA */
> -static unsigned char byVT3253B0_AGC[CB_VT3253B0_AGC][2] = {
> +static unsigned char vt3253b0_agc[CB_VT3253B0_AGC][2] = {
>  	{0xF0, 0x00},
>  	{0xF1, 0x00},
>  	{0xF0, 0x80},
> @@ -2010,8 +2010,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
>  
>  			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
>  				result &= bb_write_embedded(priv,
> -					byVT3253B0_AGC4_RFMD2959[ii][0],
> -					byVT3253B0_AGC4_RFMD2959[ii][1]);
> +					vt3253b0_agc4_rfmd2959[ii][0],
> +					vt3253b0_agc4_rfmd2959[ii][1]);
>  
>  			iowrite32(0x23, iobase + MAC_REG_ITRTMSET);
>  			vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
> @@ -2027,12 +2027,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
>  	} else if ((by_rf_type == RF_AIROHA) || (by_rf_type == RF_AL2230S)) {
>  		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_AIROHA2230[ii][0],
> -				byVT3253B0_AIROHA2230[ii][1]);
> +				vt3253b0_airoha2230[ii][0],
> +				vt3253b0_airoha2230[ii][1]);
>  
>  		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
> +				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
>  
>  		priv->abyBBVGA[0] = 0x1C;
>  		priv->abyBBVGA[1] = 0x10;
> @@ -2045,13 +2045,13 @@ bool bb_vt3253_init(struct vnt_private *priv)
>  	} else if (by_rf_type == RF_UW2451) {
>  		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_UW2451[ii][0],
> -				byVT3253B0_UW2451[ii][1]);
> +				vt3253b0_uw2451[ii][0],
> +				vt3253b0_uw2451[ii][1]);
>  
>  		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_AGC[ii][0],
> -				byVT3253B0_AGC[ii][1]);
> +				vt3253b0_agc[ii][0],
> +				vt3253b0_agc[ii][1]);
>  
>  		iowrite8(0x23, iobase + MAC_REG_ITRTMSET);
>  		vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
> @@ -2067,12 +2067,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
>  	} else if (by_rf_type == RF_VT3226) {
>  		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_AIROHA2230[ii][0],
> -				byVT3253B0_AIROHA2230[ii][1]);
> +				vt3253b0_airoha2230[ii][0],
> +				vt3253b0_airoha2230[ii][1]);
>  
>  		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
>  			result &= bb_write_embedded(priv,
> -				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
> +				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
>  
>  		priv->abyBBVGA[0] = 0x1C;
>  		priv->abyBBVGA[1] = 0x10;
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
