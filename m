Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15557E0EBA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 11:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjKDKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjKDKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:14:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1CB187;
        Sat,  4 Nov 2023 03:13:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11CDC433C8;
        Sat,  4 Nov 2023 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699092839;
        bh=chZMmG8UhsJA5IoSvLFAzHBmyGTaWY2WF6e0ozYpsOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVIoPcFP20V4vwtySBeKGf/VoD71+G1ZXsftLT9+HgYbw67CpqeQCGcHcDui3HVBy
         pIMmIIqWN57jHEZEzauGKPccoPozxZBkHOfVAH+te1PIPD0/UMleJzMlGRbfwlig4u
         ErPTYvb1DO91NtiXxuMo10rP4pX3k/vgEueAYbAk=
Date:   Sat, 4 Nov 2023 11:13:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     sudip.mukherjee@codethink.co.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cameron Williams <cang1@live.co.uk>
Subject: Re: [PATCH v2 1/2 RESEND] parport: parport_serial: Add Brainboxes
 BAR details
Message-ID: <2023110450-computer-thursday-bcd9@gregkh>
References: <AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
 <CADVatmNcq94zF=SfSudmgzfoT92ytyOFYZEYqnYObDfja5uVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNcq94zF=SfSudmgzfoT92ytyOFYZEYqnYObDfja5uVxg@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 09:45:31AM +0000, Sudip Mukherjee wrote:
> On Thu, 2 Nov 2023 at 21:08, Cameron Williams <cang1@live.co.uk> wrote:
> >
> > Add BAR/enum entries for Brainboxes serial/parallel cards.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> 
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> Greg, can you please take this series after the merge window is over.

Will do, thanks!

greg k-h
