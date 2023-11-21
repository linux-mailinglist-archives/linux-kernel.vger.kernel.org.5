Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723A7F27EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKUItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjKUItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:49:14 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A6B9;
        Tue, 21 Nov 2023 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700556547; bh=egr6QPRR9Clv2sUAEns/EfkbP1lJ5EI3ebm2kJE4fCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPXpTXhLW51zme8728ZWWqLOhKqSZavJpO94u+DXxZM5sdRYzhbwt08Vmol5W6H7x
         VAVxmJ7IN1vDG4hy1XS3HBMTzMP7+4CRD7YsMfR7CVMg/Sva1YRHD+2ynwCoDQs/gD
         7sgYtRBjK5OKNCLOz6nw5cktuAjpqcSbBa+ExWDvnsvj+S7y2IM1e7/kGDSm/yTI3K
         YRFLJaUNN+I9++PsqRKP+EIAtHPkaWSEwwZoJUcuTr/NxYTWq/mMkuNtKKtoPhmFjJ
         sxXqhZ+bfxlHrChjUC9Eb0qBBqsrYgtc7W+C7k6uJc7N1W7YgLXhf1yiMsZ4mXbpNO
         AfrfO+YEhg4Ag==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 668C91000CD; Tue, 21 Nov 2023 08:49:07 +0000 (GMT)
Date:   Tue, 21 Nov 2023 08:49:07 +0000
From:   Sean Young <sean@mess.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: drivers/media/rc/ttusbir.c:1: warning: no structured comments
 found
Message-ID: <ZVxvA58WvjBCRQyP@gofer.mess.org>
References: <202311210746.QM5MR14D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311210746.QM5MR14D-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 07:39:58AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> commit: b9e1486e0e4b5e0fc0cde214ceecec8a5734f620 media: rc-core: do not depend on MEDIA_SUPPORT
> date:   6 years ago

A bug report on a 6 year old commit? This is nowhere near current master.

> config: i386-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311210746.QM5MR14D-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/media/rc/ttusbir.c:1: warning: no structured comments found

What does that mean? Not a helpful warning message.

> vim +1 drivers/media/rc/ttusbir.c
> 
> 0938069fa08970 Sean Young 2012-08-13  @1  /*
> 0938069fa08970 Sean Young 2012-08-13   2   * TechnoTrend USB IR Receiver
> 0938069fa08970 Sean Young 2012-08-13   3   *
> 0938069fa08970 Sean Young 2012-08-13   4   * Copyright (C) 2012 Sean Young <sean@mess.org>
> 0938069fa08970 Sean Young 2012-08-13   5   *
> 0938069fa08970 Sean Young 2012-08-13   6   * This program is free software; you can redistribute it and/or modify
> 0938069fa08970 Sean Young 2012-08-13   7   * it under the terms of the GNU General Public License as published by
> 0938069fa08970 Sean Young 2012-08-13   8   * the Free Software Foundation; either version 2 of the License, or
> 0938069fa08970 Sean Young 2012-08-13   9   * (at your option) any later version.
> 0938069fa08970 Sean Young 2012-08-13  10   *
> 0938069fa08970 Sean Young 2012-08-13  11   * This program is distributed in the hope that it will be useful,
> 0938069fa08970 Sean Young 2012-08-13  12   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> 0938069fa08970 Sean Young 2012-08-13  13   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> 0938069fa08970 Sean Young 2012-08-13  14   * GNU General Public License for more details.
> 0938069fa08970 Sean Young 2012-08-13  15   */
> 0938069fa08970 Sean Young 2012-08-13  16  

Like I said, that is pretty ancient code.


Sean

> 
> :::::: The code at line 1 was first introduced by commit
> :::::: 0938069fa08970f1c898970c1331a029efe9a1ce [media] rc: Add support for the TechnoTrend USB IR Receiver
> 
> :::::: TO: Sean Young <sean@mess.org>
> :::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
