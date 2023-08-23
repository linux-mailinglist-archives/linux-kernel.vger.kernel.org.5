Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A344E785758
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHWMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjHWMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04EE62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cb6hVJz4wy7;
        Wed, 23 Aug 2023 22:03:43 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2cb498f637e082a4af8032311fad3cae84d6aa5d.1692199324.git.christophe.leroy@csgroup.eu>
References: <2cb498f637e082a4af8032311fad3cae84d6aa5d.1692199324.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/83xx: Fix style problems in usb.c and remove unneccessary includes from mpc83xx.h
Message-Id: <169279175569.797584.3444196924144422566.b4-ty@ellerman.id.au>
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

On Wed, 16 Aug 2023 17:22:16 +0200, Christophe Leroy wrote:
> Replace printk(KERN_WARN with pr_warn(
> 
> Remove a couple of blank lines
> 
> Re-align multi-line code.
> 
> Replace asm/io.h by linux/io.h
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/83xx: Fix style problems in usb.c and remove unneccessary includes from mpc83xx.h
      https://git.kernel.org/powerpc/c/d25f01fba71dbaa117021aed3ea85cc5476c1a5a
[2/2] powerpc/83xx: Split usb.c
      https://git.kernel.org/powerpc/c/5951b62ba4635881f1eb6c30e35d476871ff5d12

cheers
