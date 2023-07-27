Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4508B765852
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjG0QJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjG0QJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:09:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5832D45
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D09861ED2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66FAC433CC;
        Thu, 27 Jul 2023 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474161;
        bh=BKW9p/pISGly2FSOCBhwkervddTzedmmb/25uYVBinw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnKWlDFad2OgmYyHLLU7chcTjU6lV7204LwEJLoujbUr5T8BSVIIAnrj2/HpAzckH
         ONGCvRETCZgpXjTZDDRZgurispGxgl4H+CACraDQjOtntAFus4mIsL42wpEKMf+yJL
         foR682673ieQimA2a/h5O0oxhfPbTWSLdG6n/74LFIwITfNWpdDVm+55RSwE/1OTsC
         YVhVARPAl6GI75j5IaCSo1SMDWbLvQpJwRGPPy8w/zqmwEvU6Y0GiKYH5faHOaBYnn
         zjctWyGc89nOnKbqPjDRmnpCrSUrQp+jmBtICeFO4Sv8hatsQD0GySVYB87Wkl+pbb
         w0uTgQzcZEshw==
From:   Will Deacon <will@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, weiyongjun1@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/Kconfig: Sort the RCpc feature under the ARMv8.3 features menu
Date:   Thu, 27 Jul 2023 17:09:12 +0100
Message-Id: <169047384831.1664635.2863872456198553776.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727020324.2149960-1-zengheng4@huawei.com>
References: <20230727020324.2149960-1-zengheng4@huawei.com>
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

On Thu, 27 Jul 2023 10:03:24 +0800, Zeng Heng wrote:
> Moving LDAPR detective config under the ARMv8.3 menu would be more
> reasonable than under ARMv8.1, since this feature was released together
> with the ARMv8.3 features list.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/Kconfig: Sort the RCpc feature under the ARMv8.3 features menu
      https://git.kernel.org/arm64/c/64a0b90a3c1e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
