Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54577D261
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbjHOStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjHOStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99D1FE2;
        Tue, 15 Aug 2023 11:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E919763D89;
        Tue, 15 Aug 2023 18:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E5C433C8;
        Tue, 15 Aug 2023 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692125189;
        bh=zv5pC+Qqu8iU5zcIUK+msSKv/nfgRX2M/72yR3ws9O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQva9tmvM3AMR6Y79y6EIBuN+SqRjVKWd2QQEG54PUsyKb/WPEWDqarysEaMcu7CG
         4Nw07IjgdX13tWg26/765cqt8v+jB8kr3PJ2bzc54e2drkN5JZZlgI1VglIBJYvUM7
         f9zcJjKCXPVGOzy4mjkMEO0jxF0uuKVYwJ809t++2qEVjW/jZbHXAF+GE8tRvEyAZP
         YoeTmFP8PSo4VGAiP8GBnXclPvCG0/JIxLJR+yNY6zrNo0Y8jlX5rf0jvu2o1SLeKZ
         FwhgZAblcEVMpmamqhOvB6zrHRAK3pU2zCfPx3QFldU7ivRGOcFhdIFKynP7XUcrPD
         ViAw79u+nJsNA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: apq8064: add support to gsbi4 uart
Date:   Tue, 15 Aug 2023 11:49:11 -0700
Message-ID: <169212535062.2466993.11739627292690261281.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814150040.64133-1-david@ixit.cz>
References: <20230814150040.64133-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 17:00:40 +0200, David Heidelberg wrote:
> This patch adds support to gsbi4 uart which is used in LG Mako.
> 
> 

Applied, thanks!

[1/1] ARM: dts: apq8064: add support to gsbi4 uart
      commit: f6ce0896b4ec0683abfcc86a6facdacb72e1b23c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
