Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F87E5108
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKHHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKHHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:32:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF779A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:32:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19F9E6732D; Wed,  8 Nov 2023 08:32:40 +0100 (CET)
Date:   Wed, 8 Nov 2023 08:32:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>
Subject: Re: drivers/target/target_core_transport.c:1079:59: warning: '%s'
 directive output may be truncated writing up to 253 bytes into a
 region of size 221
Message-ID: <20231108073239.GC5277@lst.de>
References: <202311062106.HacLsl2Y-lkp@intel.com> <ZUj/USPCJ6tm/lg9@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUj/USPCJ6tm/lg9@rli9-mobl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:59:29PM +0800, Philip Li wrote:
> On Mon, Nov 06, 2023 at 10:01:44PM +0800, kernel test robot wrote:
> > Hi Christoph,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> Sorry for false report, kindly ignore this which is not the cause of initial warning.

It indeed isn't.  It still seems like a bug worth fixing, though.
