Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8030378577D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjHWMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHWMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:05:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92433E76
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:05:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4df0d2qz4x5l;
        Wed, 23 Aug 2023 22:04:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230810000740.23756-1-rdunlap@infradead.org>
References: <20230810000740.23756-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/pseries: PLPKS: undo kernel-doc comment notation
Message-Id: <169279175548.797584.6390624232158663005.b4-ty@ellerman.id.au>
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

On Wed, 09 Aug 2023 17:07:40 -0700, Randy Dunlap wrote:
> Don't use kernel-doc "/**" comment format for non-kernel-doc comments.
> This prevents a kernel-doc warning:
> 
>   arch/powerpc/platforms/pseries/plpks.c:186: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Label is combination of label attributes + name.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: PLPKS: undo kernel-doc comment notation
      https://git.kernel.org/powerpc/c/506e550a7da9e995bea3bd585db591068f98b2bf

cheers
