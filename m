Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E097F5FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjKWNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345402AbjKWNPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:15:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98C1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:15:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DBFC433C8;
        Thu, 23 Nov 2023 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700745322;
        bh=1geUD0PxSwl4jgapDcrWydrHt9Icc3WU+vTDHs1Kn8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHST/eVsPlt34bKRusq/pA0fPojvNhTL8M91927W7+2fn/NY8QZ38WSt1xoKwwM0P
         BVRwq6EjiXeZDYhZmkGPnfiihpw+jfK+gtvuGEYRCVApIrUNozGcUgo48eNIsX3LVI
         ujj+7tow3XtFTuG26iM4s+ToDrepe5MvcpVp8pQQ=
Date:   Thu, 23 Nov 2023 12:56:07 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] fixup! staging: vc04_services: bcm2835-isp: Add a more
 complex ISP processing component
Message-ID: <2023112352-ravishing-garter-c9fc@gregkh>
References: <20231109210309.638594-11-umang.jain@ideasonboard.com>
 <20231113140755.425365-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113140755.425365-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 09:07:55AM -0500, Umang Jain wrote:
> Setup DMA Mask
> ---
> I realised while (re)creating the test branches (sent in reply to the cover
> letter), I missed to squash this hunk in
> "staging: vc04_services: bcm2835-isp: Add a more complex ISP processing component"
> before sending out the series.
> 
> Sending it as a fixup! for now. 

What does that mean?  What can I do with this?

confused,

greg k-h
