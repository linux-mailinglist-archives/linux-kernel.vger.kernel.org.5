Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5E7EBD51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjKOHFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:05:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF52D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:05:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DAC433C7;
        Wed, 15 Nov 2023 07:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700031938;
        bh=bURo+kPcLtHMtWGwi2g41oHG5erQjXrGpn60QsxquK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lu/wTfXo2S6xnDcDe00IORySZopCBXK0nhdOYNnmZaCkmf3zjgHjggFbEAVvWbZEI
         jIaHiCaOwo1OYxqFg1V0+Nk8WwaROnzQocqISoDyp8dtl8K8Km8mMenajsCv1QrIbK
         u8NlDeJQUy/oBqIDl67Ud2jVGrgMBTbISQvKJhIlYWLPmHYgstvmCR3wV21HtZ2Lzv
         06FWtZ5obIpT7GT9nGCpQOl1utVX1ut8OyW1sTEl5GQl7FcD5oSfShkqPDka5JpHrx
         lgi43UESTj0xh4C9Qniwo8cM6vOw6g46hW2iLEc54pGmVjhyb/fxd3dMXvzwsdesss
         0QkEeQjs6hvIw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r39xv-0000qJ-0N;
        Wed, 15 Nov 2023 08:05:35 +0100
Date:   Wed, 15 Nov 2023 08:05:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZVRtvw7rSzJuuyIj@hovoldconsulting.com>
References: <TYZPR02MB5088D4550E1F4D9E4D66344B89B1A@TYZPR02MB5088.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR02MB5088D4550E1F4D9E4D66344B89B1A@TYZPR02MB5088.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:11:02AM +0000, Puliang Lu(Puliang) wrote:
> 
> > > Modify the definition of Fibocom USB serial option driver FM101R-GL different variants
> > > 
> > > - VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
> > >   MBIM interfaces for Linux)
> > > 
> > > - VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
> > >   MBIM interface for Linux)
> > > 
> > > 0x8213: mbim, tty
> > > 0x8215: mbim, tty
> > > 
> > > Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
> > > ---

> May I ask when this patch can be merged?

It's still in my queue and I haven't really looked at it yet. But don't
worry, it's not lost.

Johan
