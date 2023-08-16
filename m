Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E077DE08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbjHPJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbjHPJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA3E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A6D66466
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CDC433C8;
        Wed, 16 Aug 2023 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692179941;
        bh=nVL/TqyOsNdCcbvHHHzJ1ndNZ+TZjkAvxld/WLihW4c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tXRIhyRs46jmTN2PuJrTZcHOUBMHvsZ6ZDSotYjZjHF7stOiJ9CtC+c4aYB/OryaS
         4od5exEfqo/lqO5m/Hl78FQAShu426IbLirmN/nIOkk6KWwJ/luWmodDDBrWBqtmMH
         g5Tr2TvdGTI7t1veh/hFGQuTwrlxN3lctnpU4hg/vAYOWuV44CgvcFh8o57l4yFtVA
         gRttzrdPIHm3KAzbmsnYaerEgMQVebed/XW+LU5NQouVYmtDcMT0jSo7AfUozkJM+p
         JEIdetWAcabYfoDkLyMZhFn12I3YkTGONHjd94hy8jxoLRlNQAI8hE4JYH4faEN2fC
         t5Pc/O5sFDe8g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230728132841.10648-1-yuehaibing@huawei.com>
References: <20230728132841.10648-1-yuehaibing@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: 88pm860x: Remove unused extern
 declarations
Message-Id: <169217994024.821006.16625867583252208893.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 10:59:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 21:28:41 +0800, Yue Haibing wrote:
> commit 260a127bfbeb ("mfd: 88pm860x-i2c: Purge unused functions")
> left behind this.
> 
> 

Applied, thanks!

[1/1] mfd: 88pm860x: Remove unused extern declarations
      commit: 7a62adf0a9c9b1e1a3fb9aa62510faa3ddaf04ca

--
Lee Jones [李琼斯]

