Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2196A787A76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbjHXVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjHXVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:31:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1C1BCD;
        Thu, 24 Aug 2023 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KouHBYS69HsNsfO20sspquU82x2AjH40Ly3b9zA3ovw=; b=LzGqlyGDTQE40g1aBOGSHRywpl
        UIyFf1whA+hLXB0AlcLeI0o+mCaK5ohAdY/C7kA1f+z/MlXGuY247GyDfqwj3puoyHh/SDlL8dLU8
        tXLep5UAvI8w03pp5mqKRe6AfN7UVVeCdLRE1bRyNPRbif4thCHssinSzkf+5n7qfaVSBB9qT44zi
        JSN+Ea06ARpEGcblt0Ltk5l9dhd2rd+eL5E2asu+RJ8nlFEczMGOc/FqLyLVKbh0uJnh9HAZyur5u
        wKkaQf1Oh/c36ocHt9G/2W9iJMQk6D8F3SWwYW9XG3IkX7XpkNIeZAT8sFQAhw1ybxO9Ve2u8Apmt
        tr3JVA+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qZHv4-003q96-1B;
        Thu, 24 Aug 2023 21:31:10 +0000
Date:   Thu, 24 Aug 2023 14:31:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yonghong Song <yhs@meta.com>, "Erhard F." <erhard_f@mailbox.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        kernel test robot <oliver.sang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kallsyms: Add more debug output for selftest
Message-ID: <ZOfMHs1FWnzhZdMW@bombadil.infradead.org>
References: <20230824205757.never.730-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824205757.never.730-kees@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:58:00PM -0700, Kees Cook wrote:
> While debugging a recent kallsyms_selftest failure[1], I needed more
> details on what specifically was failing. This adds those details for
> each failure state that is checked.
> 
> [1] https://lore.kernel.org/all/202308232200.1c932a90-oliver.sang@intel.com/
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: "Erhard F." <erhard_f@mailbox.org>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: kernel test robot <oliver.sang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied and pushed, thanks.

  Luis
