Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127E7B57B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjJBPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbjJBPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:46:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A1A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:46:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377EC433C7;
        Mon,  2 Oct 2023 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696261612;
        bh=giO6yTDPYsIHUPl4IocJu5KNEwm8QrDYd0E9A53jQd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNWMof490ByBbYRaekI4eeVyhAPb8/GjD92mJuUyEYOdRercVeebtctz8uUzhyfcD
         fRG+cj7ZdMCrlMHs/+3S7o1FNRbJSIMZWZiu0LxWDViF0cD13z4/l0EWNHf/A57rnF
         j2ZXy2XNYU3obhiZXl9Wrv0ufCkcfmnl4M+0K/no=
Date:   Mon, 2 Oct 2023 17:46:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     swarup <swarupkotikalapudi@gmail.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: fix kernel-doc warning
Message-ID: <2023100207-unmoved-arbitrary-2c33@gregkh>
References: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
 <2023100253-aide-authentic-5aa1@gregkh>
 <ZRrkbkjoHgEnuy/m@swarup-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrkbkjoHgEnuy/m@swarup-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:10:30PM +0530, swarup wrote:
> On Mon, Oct 02, 2023 at 04:42:03PM +0200, Greg KH wrote:
> > On Tue, Sep 19, 2023 at 01:05:05AM +0530, Swarup Laxman Kotiaklapudi wrote:
> > > Fix kernel-doc warnings discovered in usb driver.
> > > Fixes this warning:
> > > warning: Function parameter or member 'gfladj_refclk_lpm_sel'
> > >          not described in 'dwc3'
> > > 
> > > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > > ---
> > >  drivers/usb/dwc3/core.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > What commit id does this fix?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> Please find the commit id as mentioned below,
> next time onwards i will mention it:
> 
> Fixes: 5cd07f96c0c6 ("usb: fix kernel-doc warning")

That is not a valid commit id in Linus's tree, are you sure it is
correct?

And please resend the patch with that information in it.

thanks,

greg k-h
