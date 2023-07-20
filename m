Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C975B980
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGTV0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGTV0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936062118
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A8261CA0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6ADC433CB;
        Thu, 20 Jul 2023 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888398;
        bh=kiS1mvvLqMomPKP3LvMcePZMepLiS1H+LHoNnXv7rRE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BWH5dmlIZV0y3Lts8MXNeGamiGJr7RNyuJ1BsB1tPKBqW2o12DUltuxqtxbg8Ievh
         umYVgcwv6SOR4W9wJqH4+5Kq5o/Y3sOYTDrO59HyDidykbS33JYMtgRelvj8kuQaRw
         x7+NULw3gbSvpTUqzF6z7FV8CA69tXkcW2HAMRJm8NHMwXIMaLqfE8dGAo5Scmk67K
         k1kN2mPXYI0efTLH/ANGuUjviKyf2ZDmWEuVK5EUW/wmWbLWiHWHxdXc3qoFWzJp3Z
         O9UDF3MXmBPc7/NLAoaWTiMX8nEEayGZik3aOjPS+2JIBybi1CdLj4psYHIqEJ5bib
         jW0q1ebemGvXA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com,
        YueHaibing <yuehaibing@huawei.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230720143506.33860-1-yuehaibing@huawei.com>
References: <20230720143506.33860-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] fs/9p: Remove unused extern declaration
Message-Id: <168988839781.88307.6903188486537085585.b4-ty@kernel.org>
Date:   Thu, 20 Jul 2023 21:26:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jul 2023 22:35:06 +0800, YueHaibing wrote:
> commit bd238fb431f3 ("9p: Reorganization of 9p file system code")
> left behind this.
> 
> 

Applied, thanks!

[1/1] fs/9p: Remove unused extern declaration
      commit: e6ab0b914c12acefbb0880dded48cb930ccab5cf

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

