Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10B7D823C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:06:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED791
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:06:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCB9C433C7;
        Thu, 26 Oct 2023 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698321978;
        bh=oc+8EGwJv3pFq0lsAUehXOOja+Aoub3w/XTW0b6Dd38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rsvy5vG0ErV1wrfzcjw6mAofeCRe+mbpXmA8qBiOCleMI2KKJ4cdG9omV3WBlIITV
         Vvupg95Aa61o9AXHs+uqLxU46i0fJdYszKN21iql5ctj5LD/TwckfAgz3x8CJittkP
         DpK2qfzN180fOYIbiUsSnk8h/0ZUqIaBAWKwaK8ibsASULkVstKMYLHV0DBMrY5+6h
         7TVTx2CCxYQlfsC0SwJ59wepPCMZ88kGvzuRquRbqRajDf4GrfkU/3NDIII21HxQbQ
         NPvCq1sRj141iq6fUUfmvlfoplgUaBe5TThXGAHw/B6+VtrSLUNA1+G1k179d2cQ9/
         dahI1qHO4xC7w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvz8L-0003FY-0B;
        Thu, 26 Oct 2023 14:06:41 +0200
Date:   Thu, 26 Oct 2023 14:06:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZTpWUYCkaGGGlG5Z@hovoldconsulting.com>
References: <TYZPR02MB508866DABCF200C7687E184889DDA@TYZPR02MB5088.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR02MB508866DABCF200C7687E184889DDA@TYZPR02MB5088.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:44:37AM +0000, Puliang Lu(Puliang) wrote:
> On Tue, 24 Oct 2023 09:24:20 +0200, Johan Hovold wrote:
> 
> > No, this patch is already in Linus's tree so that's not possible. But
> > please do send a follow-up incremental fix.

> Thank you for your reply. 
> We have decided not to address this issue because it does not 
> affect the operation of modem. 

No, that's not the way things work.

Please do send an incremental fix so that this is corrected. Otherwise
I'll just revert your patch.

Johan
