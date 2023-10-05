Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6127BA3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjJEP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjJEP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11405267
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291BEC43142;
        Thu,  5 Oct 2023 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696492616;
        bh=p3oq5Wv249cq7oz6AShBD6LFkP/SyYsL+Ta6uUFwOtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMIWqYo780prfbTmpFj0IZfbX1x4554PW1FxDS9TWU5UPfUbc3p5+45qUO0e6kmqz
         5ot+32dfYd6+kOvfNWX4EomGgW3fLLPbWFnP7v9c4kLYp5xcxTgUfpyFVKm9pEMCEn
         kO6sqdAaIz1XwxNHekBi2729kSaekevAHqiwuiIo=
Date:   Thu, 5 Oct 2023 09:56:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6655: Type encoding info dropped from
 array name "abyBBVGA"
Message-ID: <2023100513-handball-landed-d7ff@gregkh>
References: <ZRWWcGiySdLbCM3z@ubuntu.myguest.virtualbox.org>
 <29dc3df5-f313-f194-7f73-3207215e0864@gmail.com>
 <76e75a6a-b3f5-4f96-a9c6-b01f8f491140@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76e75a6a-b3f5-4f96-a9c6-b01f8f491140@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:19:53AM +0300, Dan Carpenter wrote:
> On Thu, Sep 28, 2023 at 08:34:40PM +0200, Philipp Hortmann wrote:
> > On 9/28/23 17:06, Pavan Bobba wrote:
> > > array name "abyBBVGA" updated like below:
> > > 
> > > a.type encoding info dropped from name
> > > b.camelcase name replaced by snakecase
> > > 
> > > Issue found by checkpatch
> > > 
> > > Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> > 
> > 
> > A coverletter is missing.
> > 
> 
> The coverletter isn't required, but the more important issue is that the
> patchset wasn't sent as a thread but instead as separate emails.

I agree, our tools can not handl this.

Pavan, please resend these all as a patch series, properly threaded
together.  Tools like 'git send-email' or 'b4' will do this for you
automatically.

thanks,

greg k-h
