Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6C7B4583
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjJAGGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjJAGGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:06:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68222A7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:06:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17905C433C7;
        Sun,  1 Oct 2023 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696140369;
        bh=EunzAtVRcUsF9o6B6FHmIwvRxk8PXJwsGkPsvupw0MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLNRNEMlcvYjnZseSVoV64pf6GrG4Pvtl6ENR0mqGXEO7dpqxBLJwSDRsp4EGUR+r
         8JIGsPJZC+37loUsv74BDG7bArjFcriguAcZnuSrzdxuM1LThtap91SiSWNeLy2NlI
         BL3xrIoQY21oHL05HWWNe9Va2IqprRRzsYvta0Ng=
Date:   Sun, 1 Oct 2023 08:06:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: usb: Fix block comments whose trailing */
 was not on a separate line
Message-ID: <2023100133-exclusive-boss-edc4@gregkh>
References: <20230930203646.61863-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930203646.61863-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:36:46PM +0200, Jonathan Bergh wrote:
> Fixed various instances where block comments trailing */ where not on a
> separate line and should be.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/usb/atm/cxacru.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Your subject line for these patches is not correct, please fix up.

And the patches are not properly threaded, what happened in your email
client?

And finally, why make coding style changes outside of drivers/staging/?
Did you get the maintainer's approval to do so before taking the time?
Usually most maintainers do not want these so always ask before doing
so, or just stick with drivers/staging/ to learn how the process works
first please.

thanks,

greg k-h
