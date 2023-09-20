Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDA7A8ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjITRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjITRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7ACE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D23C433C7;
        Wed, 20 Sep 2023 17:40:21 +0000 (UTC)
Date:   Wed, 20 Sep 2023 18:40:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] mm: slab: Do not create kmalloc caches smaller than
 arch_slab_minalign()
Message-ID: <ZQsugrms6Vgd3yDV@arm.com>
References: <20230920173149.2983892-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920173149.2983892-1-catalin.marinas@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 06:31:49PM +0100, Catalin Marinas wrote:
> base-commit: e1df27213941725962f68c64349bbcc60ece0314

The patch was on top of 6.6-rc1. How git generated this base-commit I
can't tell yet.

> prerequisite-patch-id: b7fd527dd443902936bad1beb25d8fbdca717805
[...]
> prerequisite-patch-id: 81f49df909f2212885086c08f18b8b29ab61ab2e

And I have no idea what this long list is. Please ignore this part.

-- 
Catalin
