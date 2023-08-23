Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A203785767
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjHWME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjHWMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BAE7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cp2Cddz4x2S;
        Wed, 23 Aug 2023 22:03:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
References: <b056c4e986a4a7707fc1994304c34f7bd15d6871.1691474658.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/6] powerpc/include: Remove unneeded #include <asm/fs_pd.h>
Message-Id: <169279175564.797584.5057179018617962889.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 08:04:38 +0200, Christophe Leroy wrote:
> tqm8xx_setup.c and fs_enet.h don't use any items provided by fs_pd.h
> 
> Remove unneeded #include <asm/fs_pd.h>
> 
> 

Applied to powerpc/next.

[1/6] powerpc/include: Remove unneeded #include <asm/fs_pd.h>
      https://git.kernel.org/powerpc/c/60bc069c433fc89caa97927b1636401a0e647f67
[2/6] powerpc/include: Declare mpc8xx_immr in 8xx_immap.h
      https://git.kernel.org/powerpc/c/e6e077cb2aa4ffb8b320f9a1464f29a21986a901
[3/6] powerpc/include: Remove mpc8260.h and m82xx_pci.h
      https://git.kernel.org/powerpc/c/fecc436a97afed920486be609c3989e05547a384
[4/6] powerpc: Remove CONFIG_PCI_8260
      https://git.kernel.org/powerpc/c/cb888cdf741c958cae3e00b649fb7ed5c9bb2d49
[5/6] powerpc/8xx: Remove immr_map() and immr_unmap()
      https://git.kernel.org/powerpc/c/fbbf4280dae4c02d2f176a8fdac7a7d32fe76fc0
[6/6] powerpc/cpm2: Remove cpm2_map() and cpm2_unmap()
      https://git.kernel.org/powerpc/c/7768716d2f1906c9258ed4b39584da6317020594

cheers
