Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2E77A8A17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjITRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjITRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64076A9;
        Wed, 20 Sep 2023 10:10:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C01C433CA;
        Wed, 20 Sep 2023 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229810;
        bh=bB0qjLN3xu5fQIW9naPhTUwyRS4e4yTiLxdyWnBr1FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOI+g9FUzO2kYK0xRnWTKznj1kBkZ1EwHnucg1uwQMzzb4zy8AUMIZ1mMkDbzvWEH
         NMg98QzVe+3k/okbzfrIG1S2TqqXr36Yhwu8D40vys7/gOikX1rnwqn64r0mobbwsE
         38+PIozAsPvGCDw3UjdUONdCQgXXlLQPIMYF7bpJB05j+85710wpEvOsGyLeuu6bTr
         dpnMQ1+BXJLFzjvGPrrpJL426D+yDVAm8tU72dMISJWXir+vCw9Ou2Si8iTxxEBcD/
         dQEQlTidWHSrOVmv3zM0RqfuC56JH+sF91OXb2U8K1wSdGpry+AnBVGniE+ZCAO8Te
         KitgXm6KnXpHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM7150 SCM
Date:   Wed, 20 Sep 2023 10:13:58 -0700
Message-ID: <169523004955.2665018.14207587632973139123.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913194418.30272-1-danila@jiaxyga.com>
References: <20230913194418.30272-1-danila@jiaxyga.com>
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


On Wed, 13 Sep 2023 22:44:18 +0300, Danila Tikhonov wrote:
> Document the compatible for Qualcomm SM7150 SCM.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: document Qualcomm SM7150 SCM
      commit: eb3da369ccd07c0e3d65cd9cd31ca44f9f709673

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
