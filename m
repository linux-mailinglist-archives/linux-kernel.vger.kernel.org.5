Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D0766B14
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjG1KyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjG1KyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C18212A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93D24620DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D8FC433C7;
        Fri, 28 Jul 2023 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541644;
        bh=SePHODk822I/BP/pJSQAM2jHtL1lWsGPb6LZaHl/Ebs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iEILmxl69a1VPg3oY/TINNGrikGODaglp+cwPQ1g8APkgNKaYzgcu2bFqo0GrnPq4
         Z8LJWlN6aTQWdpthFgv8vkWXLquqmZiJK9EI8jCtsFcVLwilBDI8Nm4gSvJiSZnj/V
         AFPGPrJfHk0hV4IDeAFVPQWLOuy6noQID1evjy4vl3sgXeE9V5DXPx5LEy0zCsXCF/
         TfvAIu93msGPD57etG1syyUktWjLD5wxm9N/+HI+FJ/QKwPw0lEvDVJjnkEvN2+kIz
         uhTew4zrDvoqQSaXOeUaGY8NmG5ylAHdPyNYfEoLYSVyQkH36Y8vc/ehNmX5gNuduk
         gDJJz7eOb9mqg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230720143738.13996-1-yuehaibing@huawei.com>
References: <20230720143738.13996-1-yuehaibing@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: db8500-prcmu: Remove unused inline
 functions
Message-Id: <169054164293.335251.14736488879818640661.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:54:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 22:37:38 +0800, YueHaibing wrote:
> Since commit b0e846248de5 ("mfd: db8500-prcmu: Remove dead code for a non-existing config")
> these inline helpers also no need any more.
> 
> 

Applied, thanks!

[1/1] mfd: db8500-prcmu: Remove unused inline functions
      commit: 6b83c9bdd5f19827c258bc8776cd0911ec31123a

--
Lee Jones [李琼斯]

