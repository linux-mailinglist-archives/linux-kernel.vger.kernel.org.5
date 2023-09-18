Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671177A56AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjISAkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISAkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:40:40 -0400
X-Greylist: delayed 2892 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 17:40:33 PDT
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B19B9107;
        Mon, 18 Sep 2023 17:40:33 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 38INfC75019228;
        Mon, 18 Sep 2023 18:41:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 38INf80d019225;
        Mon, 18 Sep 2023 18:41:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 18 Sep 2023 18:41:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     reiserfs-devel@vger.kernel.org, tsbogend@alpha.franken.de,
        jack@suse.cz, linux-sh@vger.kernel.org, ink@jurassic.park.msu.ru,
        richard@nod.at, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        johannes@sipsolutions.net, richard.henderson@linaro.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230918234108.GN19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> ReiserFS has been considered deprecated for 19 months since commit
> eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> several architectures that still build it into their defconfig kernels.
> 
> As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> from defconfig files before the filesystem's removal.

This is essentially equivalent to deleting the filesystem now.  Why do
this?  Is there such a hurry?


Segher
