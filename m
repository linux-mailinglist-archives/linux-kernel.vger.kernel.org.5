Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCD790B3A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjICIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjICIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:32:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5DCD8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E920ECE09B6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0EFC433C7;
        Sun,  3 Sep 2023 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693729970;
        bh=dejmVue97D9aQerL3bLNV+IfoBD8EQK0FMfsFCqtm9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlEg4h/HRf8LgFANNgVxEpxFNWsc+3hFTMOI4TUhqXGh/bmdrabGGJfuktnCf7RnL
         h09pPxH2yuUQE/xQtViMuFN7BEreEdlhhVo8awS2TPYiAwhONzLAPBL7+FaITfHxDI
         iVLpqTcGfP6+FD9XQ0wf/lLuj0QEeC4wmgAvlky8=
Date:   Sun, 3 Sep 2023 10:32:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: Fixed some formatting warnings in the vme_user
 driver
Message-ID: <2023090324-recopy-unisexual-db41@gregkh>
References: <20230903082253.562042-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903082253.562042-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:22:53AM +0200, Jonathan Bergh wrote:
> Fixed a few style warnings.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c   |   4 +-
>  drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
>  2 files changed, 72 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 7c53a8a7b79b..90aaf650524d 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1010,8 +1010,8 @@ static void fake_free_consistent(struct device *parent, size_t size,
>  {
>  	kfree(vaddr);
>  /*
> -	dma_free_coherent(parent, size, vaddr, dma);
> -*/
> + *	dma_free_coherent(parent, size, vaddr, dma);
> + */
>  }
>  
>  /*
> diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> index 63f726e1811a..23969393b606 100644
> --- a/drivers/staging/vme_user/vme_tsi148.h
> +++ b/drivers/staging/vme_user/vme_tsi148.h
> @@ -255,28 +255,28 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
>   */
>  #define TSI148_LCSR_VMEFL	0x250
>  
> -	/*
> -	 * VME exception.
> -	 * offset  260
> +/*
> + * VME exception.
> + * offset  260
>   */
>  #define TSI148_LCSR_VEAU	0x260
>  #define TSI148_LCSR_VEAL	0x264
>  #define TSI148_LCSR_VEAT	0x268
>  
> -	/*
> -	 * PCI error
> -	 * offset  270
> -	 */
> +/*
> + * PCI error
> + * offset  270
> + */
>  #define TSI148_LCSR_EDPAU	0x270
>  #define TSI148_LCSR_EDPAL	0x274
>  #define TSI148_LCSR_EDPXA	0x278
>  #define TSI148_LCSR_EDPXS	0x27C
>  #define TSI148_LCSR_EDPAT	0x280
>  
> -	/*
> -	 * Inbound Translations
> -	 * offset  300
> -	 */
> +/*
> + * Inbound Translations
> + * offset  300
> + */
>  #define TSI148_LCSR_IT0_ITSAU		0x300
>  #define TSI148_LCSR_IT0_ITSAL		0x304
>  #define TSI148_LCSR_IT0_ITEAU		0x308
> @@ -363,53 +363,53 @@ static const int TSI148_LCSR_IT[8] = { TSI148_LCSR_IT0, TSI148_LCSR_IT1,
>  #define TSI148_LCSR_OFFSET_ITOFL	0x14
>  #define TSI148_LCSR_OFFSET_ITAT		0x18
>  
> -	/*
> -	 * Inbound Translation GCSR
> -	 * offset  400
> -	 */
> +/*
> + * Inbound Translation GCSR
> + * offset  400
> + */
>  #define TSI148_LCSR_GBAU	0x400
>  #define TSI148_LCSR_GBAL	0x404
>  #define TSI148_LCSR_GCSRAT	0x408
>  
> -	/*
> -	 * Inbound Translation CRG
> -	 * offset  40C
> -	 */
> +/*
> + * Inbound Translation CRG
> + * offset  40C
> + */
>  #define TSI148_LCSR_CBAU	0x40C
>  #define TSI148_LCSR_CBAL	0x410
>  #define TSI148_LCSR_CSRAT	0x414
>  
> -	/*
> -	 * Inbound Translation CR/CSR
> -	 *         CRG
> -	 * offset  418
> -	 */
> +/*
> + * Inbound Translation CR/CSR
> + *         CRG
> + * offset  418
> + */
>  #define TSI148_LCSR_CROU	0x418
>  #define TSI148_LCSR_CROL	0x41C
>  #define TSI148_LCSR_CRAT	0x420
>  
> -	/*
> -	 * Inbound Translation Location Monitor
> -	 * offset  424
> -	 */
> +/*
> + * Inbound Translation Location Monitor
> + * offset  424
> + */
>  #define TSI148_LCSR_LMBAU	0x424
>  #define TSI148_LCSR_LMBAL	0x428
>  #define TSI148_LCSR_LMAT	0x42C
>  
> -	/*
> -	 * VMEbus Interrupt Control.
> -	 * offset  430
> -	 */
> +/*
> + * VMEbus Interrupt Control.
> + * offset  430
> + */
>  #define TSI148_LCSR_BCU		0x430
>  #define TSI148_LCSR_BCL		0x434
>  #define TSI148_LCSR_BPGTR	0x438
>  #define TSI148_LCSR_BPCTR	0x43C
>  #define TSI148_LCSR_VICR	0x440
>  
> -	/*
> -	 * Local Bus Interrupt Control.
> -	 * offset  448
> -	 */
> +/*
> + * Local Bus Interrupt Control.
> + * offset  448
> + */
>  #define TSI148_LCSR_INTEN	0x448
>  #define TSI148_LCSR_INTEO	0x44C
>  #define TSI148_LCSR_INTS	0x450
> @@ -417,10 +417,10 @@ static const int TSI148_LCSR_IT[8] = { TSI148_LCSR_IT0, TSI148_LCSR_IT1,
>  #define TSI148_LCSR_INTM1	0x458
>  #define TSI148_LCSR_INTM2	0x45C
>  
> -	/*
> -	 * DMA Controllers
> -	 * offset 500
> -	 */
> +/*
> + * DMA Controllers
> + * offset 500
> + */
>  #define TSI148_LCSR_DCTL0	0x500
>  #define TSI148_LCSR_DSTA0	0x504
>  #define TSI148_LCSR_DCSAU0	0x508
> @@ -484,27 +484,27 @@ static const int TSI148_LCSR_DMA[TSI148_MAX_DMA] = { TSI148_LCSR_DMA0,
>  #define TSI148_LCSR_OFFSET_DCNT		0x40
>  #define TSI148_LCSR_OFFSET_DDBS		0x44
>  
> -	/*
> -	 * GCSR Register Group
> -	 */
> +/*
> + * GCSR Register Group
> + */
>  
> -	/*
> -	 *         GCSR    CRG
> -	 * offset   00     600 - DEVI/VENI
> -	 * offset   04     604 - CTRL/GA/REVID
> -	 * offset   08     608 - Semaphore3/2/1/0
> -	 * offset   0C     60C - Seamphore7/6/5/4
> -	 */
> +/*
> + *         GCSR    CRG
> + * offset   00     600 - DEVI/VENI
> + * offset   04     604 - CTRL/GA/REVID
> + * offset   08     608 - Semaphore3/2/1/0
> + * offset   0C     60C - Seamphore7/6/5/4
> + */
>  #define TSI148_GCSR_ID		0x600
>  #define TSI148_GCSR_CSR		0x604
>  #define TSI148_GCSR_SEMA0	0x608
>  #define TSI148_GCSR_SEMA1	0x60C
>  
> -	/*
> -	 * Mail Box
> -	 *         GCSR    CRG
> -	 * offset   10     610 - Mailbox0
> -	 */
> +/*
> + * Mail Box
> + *         GCSR    CRG
> + * offset   10     610 - Mailbox0
> + */
>  #define TSI148_GCSR_MBOX0	0x610
>  #define TSI148_GCSR_MBOX1	0x614
>  #define TSI148_GCSR_MBOX2	0x618
> @@ -515,27 +515,27 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
>  					TSI148_GCSR_MBOX2,
>  					TSI148_GCSR_MBOX3 };
>  
> -	/*
> -	 * CR/CSR
> -	 */
> +/*
> + * CR/CSR
> + */
>  
> -	/*
> -	 *        CR/CSR   CRG
> -	 * offset  7FFF4   FF4 - CSRBCR
> -	 * offset  7FFF8   FF8 - CSRBSR
> -	 * offset  7FFFC   FFC - CBAR
> -	 */
> +/*
> + *        CR/CSR   CRG
> + * offset  7FFF4   FF4 - CSRBCR
> + * offset  7FFF8   FF8 - CSRBSR
> + * offset  7FFFC   FFC - CBAR
> + */
>  #define TSI148_CSRBCR	0xFF4
>  #define TSI148_CSRBSR	0xFF8
>  #define TSI148_CBAR	0xFFC
>  
> -	/*
> -	 *  TSI148 Register Bit Definitions
> -	 */
> +/*
> + *  TSI148 Register Bit Definitions
> + */
>  
> -	/*
> -	 *  PFCS Register Set
> -	 */
> +/*
> + *  PFCS Register Set
> + */
>  #define TSI148_PCFS_CMMD_SERR          BIT(8)	/* SERR_L out pin ssys err */
>  #define TSI148_PCFS_CMMD_PERR          BIT(6)	/* PERR_L out pin  parity */
>  #define TSI148_PCFS_CMMD_MSTR          BIT(2)	/* PCI bus master */
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
