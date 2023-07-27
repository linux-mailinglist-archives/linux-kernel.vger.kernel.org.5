Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD437653B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjG0MYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjG0MXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A63C3F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EBD61E58
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46F4C433C8;
        Thu, 27 Jul 2023 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460593;
        bh=1fL8acOzO4HglIbnmW3yjd1tDafwA7MSFTfKHXk7Uh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcgt3KGoVjghLQrdIpzU8dM9UG8r1xxsHhWxcDb5tBpeIumMs+kdcGLUGbXQkiZ2D
         oP4foxado9boYLFE2uUGFjVftMQSHvN8Sp96LMGL8c7/+mb8ehnovEvjVhu1rOSvF7
         laHAnq06pxr6vvjRpx/uXmsu0mRLXeW16Q7atvWHGhKJ5IHTh6LepeIpj3hY8hf67S
         Blz97/CTRSAMzEk9yt8rACh37icJPuwIhT9GBc9v5fyldC6Sy/zJUA4O9jUu8c0nTn
         KBOYgnbHGDDG8hlkAZ8dVIqhBAG6ma+v39kCofAiS4XG082181xIEkXMwtlJDPfuWi
         guo9vIjt8jfUA==
From:   Will Deacon <will@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64: Remove unsued extern declaration init_mem_pgprot()
Date:   Thu, 27 Jul 2023 13:22:38 +0100
Message-Id: <169045308266.2141985.4969454510755101935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230720143555.26044-1-yuehaibing@huawei.com>
References: <20230720143555.26044-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 22:35:55 +0800, YueHaibing wrote:
> commit a501e32430d4 ("arm64: Clean up the default pgprot setting")
> left behind this.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: Remove unsued extern declaration init_mem_pgprot()
      https://git.kernel.org/arm64/c/42501f6d4d5d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
