Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60CF7C9891
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjJOKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjJOKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:06:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DDBDE;
        Sun, 15 Oct 2023 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364368;
        bh=i4UWmSXRdf8U3S13I3kD1JSY13lhFBz1uoD0N3O5gJM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gJBgCvZaEh9UB1j8l9jgl1lcm9tKhfgJp9ItNPM9Hj3n7fbEgL8m+iRP9O0vHZAgR
         UBK77/niEbZXGJQWrrYT2xxm8zjejGl14XMaPzkLlLLTeAE9m7RPyXvuXYonrP4ZYm
         MeAcgvITgft32SbCtgN+Sv7eCSiaHlr8BPPua5qvKAtqfxmlppHwkbqhvXA8WlX1Kt
         LVr0BPr3a/zXmElcDvv8bj7MGn5nly4LU/6t1w8esohXrYX7wTBqXs4vAWpKDf362v
         yyR5RTdmpoVzPLvXesfWxE2zH6UJTKLkzyzght/sVyGAmETiC7k0N6sJpWsFBvrNHg
         VRK1ozDCF1xJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVQ4zgTz4wcc;
        Sun, 15 Oct 2023 21:06:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1695031668.git.geert@linux-m68k.org>
References: <cover.1695031668.git.geert@linux-m68k.org>
Subject: Re: (subset) [PATCH v2 0/2] m68k/powerpc: Kill references to non-existent README.legal
Message-Id: <169736429851.960528.8922488798725928458.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 12:14:42 +0200, Geert Uytterhoeven wrote:
> Note that the "COPYING" file at that time corresponded to the version
> from upstream Linux v0.99.11 until v2.1.104, and thus predated the
> addition of the "only valid GPL version is v2" clause in v2.4.0-test8.
> 
> This patch series gets rid of the references to README.legal by
> replacing the boilerplate with SPDX license identifiers.
> 
> [...]

Applied to powerpc/next.

[2/2] powerpc: Replace GPL 2.0+ README.legal boilerplate with SPDX
      https://git.kernel.org/powerpc/c/6fcb13972bc2b41211e1dddb02f5e73199addc75

cheers
