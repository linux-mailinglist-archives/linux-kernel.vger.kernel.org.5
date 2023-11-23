Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC997F6590
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbjKWRgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345646AbjKWRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:36:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630211BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:36:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D683BC433C9;
        Thu, 23 Nov 2023 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761018;
        bh=C8UA/rmJkwKNOvA+j0N7u0n3ZpA0Xbr76wwlbqBsBgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ/FIbgpYTwbh6hw5SDTMFcgqTknmvhiZWwTmNEjSOqDzdGz/GOguYK8as75M+R5Y
         tozsk4RqjHmYiAtheR+y49B33Mw6f9Ebgnm2HbXktnwNX9FxrgsdaDi9UpNfOIN4+w
         ruP8E+dJJV6qya7wMrQcw7rlaDePHNxYg3iZeWfWKUvWfvvF2OsJGZR+vsOXW/MJIr
         8QC8MNtlCqMmZT7wuV5q1virzvelLiII/qUflUjnRro92jTpb5GW6X+NXos5NXaoO5
         LQfWoUuB2sCsEeXR/+bMZPDSP0HyGQceeg2Z//j9uNKktMXFTZ85zbV1QryCX1+jHt
         KFhjDIispc5hA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6Ddc-0006zw-1v;
        Thu, 23 Nov 2023 18:37:17 +0100
Date:   Thu, 23 Nov 2023 18:37:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Asuna Yang <spriteovo@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2] USB: serial: option: add Luat Air72*U series products
Message-ID: <ZV-NzHAcmfpVmG5w@hovoldconsulting.com>
References: <20231122141803.82844-1-SpriteOvO@gmail.com>
 <ZV9BaBBrn78i0x64@hovoldconsulting.com>
 <921fc036-7ebb-43cf-b4a3-de7a7c993bbf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921fc036-7ebb-43cf-b4a3-de7a7c993bbf@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 01:03:46AM +0800, Asuna Yang wrote:
> If#= 2: AT
> If#= 3: PPP + AT
> If#= 4: Debug
> 
> Reference from the device documentation:
> https://doc.openluat.com/wiki/21?wiki_page_id=2501

Thanks for the details.

> Should I send a v3 to include the serial interfaces information in the 
> git message? This is my first time sending a patch to the kernel, please 
> forgive me for not being particularly sure of the process.

No, that's ok, I can just amend the commit message when applying.

For your next contribution, just keep in mind that top-posting should be
avoided when replying on the mailing lists (instead reply inline after
trimming unnecessary context as I did here).

And congratulations on your first merged kernel patch. :)

Johan
