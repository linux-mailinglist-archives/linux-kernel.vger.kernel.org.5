Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5D769BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjGaQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjGaQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:03:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080AAE45;
        Mon, 31 Jul 2023 09:03:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8BF2E2B0;
        Mon, 31 Jul 2023 16:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8BF2E2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690819390; bh=6DZuq3K0IVlWprkW7UxAsqG3o6fDHDawj8kLGq2UaX4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JM5UkfFEyC3fj9Qk4pNUCg8AnEHpsETABUjjbve3Y3yn2B/72TmhTPlL3OhE5Mr/e
         PyZdw9rp20TgtbJvtuXC7GdCAxzb+0abIDaHc4ZNvblp5mcZG1iRfFmsgyQyB/7o73
         QwLelHb+VQwYjJlp3+CMjUJdGCyohcSuYfkVbUsrpZMMfacb9TWLobaQVnnGvm+gF+
         06kblk4KGnkqiJZUcUZd4bYxBPpGfGfVdLA8FaKM0AoP++n+A5dEE802zEfevc4E2e
         swL7pa1EJKOLdoEdKHJZJQmVsM5RxLtfuLoSkwSY/mVBDHhY5d62Ai4odK1UqV1Ir/
         O/JT/ukJ48CZg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v6 1/3] Documentation: arm: Add bootargs to the table of
 added DT parameters
In-Reply-To: <20230725141926.823153-1-alexghiti@rivosinc.com>
References: <20230725141926.823153-1-alexghiti@rivosinc.com>
Date:   Mon, 31 Jul 2023 10:03:09 -0600
Message-ID: <87fs54dq6a.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The bootargs node is also added by the EFI stub in the function
> update_fdt(), so add it to the table.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>
> - Changes in v5:
>   * Rebase on top of docs-next
>
>  Documentation/arch/arm/uefi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Series applied, thanks.

jon
