Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09477CFEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbjJSP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJSP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:56:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D857106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:56:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A34C433C7;
        Thu, 19 Oct 2023 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697730961;
        bh=haRCOkN73wLvU3HdzEVJZt/eh6HF70wED8hxlg8ZNA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRxuOZvpSnyUST7JnSiju4ZRgp2YLiIAJvpQcdHFTbsAWctHD74BQGZWiRC0qY+a5
         K7IgBpxU7IzMogz5eGkTTeu/EXsf3TIANvg0r65NaS3/HjvbBIfDX7EZsb/UIOF6n2
         C1i5inQu59XewjcLdeZfT5oex/n2t4ajVdiIA1jKrTOZLffJHg56BK/dOieR39b8KI
         T+0eMAvopRzVzGvCTYaTpFMqDPGBJdcvR+uoZy/wvIGLk/q4ifpAFY7AlJOX2EjeCD
         UeZ5M3jT7/6w9Pv3vMPVze9jvuZ+y8y64yv/eY/lspRxiZriuNn9TLvTbh3CkiP1rN
         3Yx8OeCdE9TSA==
Date:   Thu, 19 Oct 2023 17:55:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019155556.GJ2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
 <20231019122740.GG2100445@kernel.org>
 <20231019134755.GB3373@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019134755.GB3373@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:47:55AM -0700, Nandha Kumar Singaram wrote:
> On Thu, Oct 19, 2023 at 02:27:40PM +0200, Simon Horman wrote:
> > On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> > > Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> > > "CHECK" output "Prefer using the BIT macro"
> > > 
> > > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > 
> > Thanks Nandha,
> > 
> > these changes look good to me.
> > But I would like to ask if not updating
> > Q_LEN_V and LEN_V is intentional.
> 
> Thanks for the review Simon.
> 
> I have already sent a patch for Q_LEN_V and LEN_V and it is accepted
> by greg k-h, so didn't updated here.

Understood, in that case this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

