Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428A3785761
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjHWMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjHWMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD7E62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4ck1hL6z4x2K;
        Wed, 23 Aug 2023 22:03:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2115e3597d81e72a865820af54f0e290d0fd2b3a.1692199186.git.christophe.leroy@csgroup.eu>
References: <2115e3597d81e72a865820af54f0e290d0fd2b3a.1692199186.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/fsl_pci: Make fsl_add_bridge() static
Message-Id: <169279175569.797584.16230105849895300688.b4-ty@ellerman.id.au>
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

On Wed, 16 Aug 2023 17:19:54 +0200, Christophe Leroy wrote:
> Since commit 905e75c46dba ("powerpc/fsl-pci: Unify pci/pcie initialization code")
> fsl_add_bridge() is not used anymore outside of fsl_pci.c
> 
> Make it static.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/fsl_pci: Make fsl_add_bridge() static
      https://git.kernel.org/powerpc/c/6960c53c4c32865a7e79022e626aa82b64da4110

cheers
