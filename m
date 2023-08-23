Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D10785769
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjHWMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjHWMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA73E65
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cr3brtz4wxQ;
        Wed, 23 Aug 2023 22:03:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <36a19e13025dbf17e92e832dd24150642b0e9bad.1692341499.git.christophe.leroy@csgroup.eu>
References: <36a19e13025dbf17e92e832dd24150642b0e9bad.1692341499.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/512x: Make mpc512x_select_reset_compat() static
Message-Id: <169279175576.797584.9419412535329287.b4-ty@ellerman.id.au>
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

On Fri, 18 Aug 2023 08:51:48 +0200, Christophe Leroy wrote:
> mpc512x_select_reset_compat() is only used in the file it
> is defined.
> 
> Make it static.
> 
> Move mpc512x_restart_init() after mpc512x_select_reset_compat().
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/512x: Make mpc512x_select_reset_compat() static
      https://git.kernel.org/powerpc/c/be922070d0914c6642256ceec6b7be75c0a5ddf3

cheers
