Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD73785765
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjHWMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjHWMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898EE63
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cm5bctz4x2Q;
        Wed, 23 Aug 2023 22:03:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cf652e47ea9e453e89813611b6f76d0939a12063.1687344017.git.christophe.leroy@csgroup.eu>
References: <cf652e47ea9e453e89813611b6f76d0939a12063.1687344017.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/reg: Remove #ifdef around mtspr macro
Message-Id: <169279175565.797584.12691137360042115730.b4-ty@ellerman.id.au>
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

On Wed, 21 Jun 2023 12:40:50 +0200, Christophe Leroy wrote:
> That ifdef was introduced by commit 1458dd951f7c ("powerpc/8xx:
> Handle CPU6 ERRATA directly in mtspr() macro") and left over by
> commit 2a45addd21de ("powerpc/8xx: Remove CPU6 ERRATA Workaround")
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/reg: Remove #ifdef around mtspr macro
      https://git.kernel.org/powerpc/c/6039fcd3fba99451ea9d013c4d3a65a40b2feff0

cheers
