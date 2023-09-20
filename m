Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183C17A7820
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjITJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjITJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:56:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C80A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:55:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F105C433C7;
        Wed, 20 Sep 2023 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695203754;
        bh=ymi9AhxzEGfr3xbpAVk8Lsx1Ioa9TTKYbM7aBR7wfxo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=NZWdErQoXneCkYIehhA1X+hogrP2+g2oIViQnRRtEPRMgqRnVWkKXqithvecSM0yR
         wk7zP2cUa8ZHH0qNcWdZGvvoNVFD/ilQn18YFePP6kHy1mfGaCUegA3oQ0Bd5m2AcI
         LQBqlxyopnMbfp/KoAhtHzWsl1GSWA0Vu2DMB9amPZO6dDuUoWhZZH711hBokJg/12
         iQ8pkR1xCeJMY3gJhdlSNZvbQnRXY8g/r3N+VKfvzPV6H96iSEKeR8lj6T2IGkx9sq
         2GneXG8YO4+lzz9kimJyGYRWd/JA2TnpFXAzaLsoWW0NjG8ChLamJjcTDfaqUclY12
         4TLTHJkbhYKOg==
From:   Lee Jones <lee@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905075558.21219-1-krzysztof.kozlowski@linaro.org>
References: <20230905075558.21219-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Revert "dt-bindings: mfd:
 maxim,max77693: Add USB connector"
Message-Id: <169520375325.3364278.14078224668543411816.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:55:53 +0100
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

On Tue, 05 Sep 2023 09:55:58 +0200, Krzysztof Kozlowski wrote:
> This reverts commit da7ee30ae6662f016f28a9ef090b2132b3c0fb48.
> 
> Commit da7ee30ae666 ("dt-bindings: mfd: maxim,max77693: Add USB
> connector") was an earlier version of my patch adding the connector,
> later superseded by commit 789c9ce9b46f ("dt-bindings: mfd:
> maxim,max77693: Add USB connector").
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: Revert "dt-bindings: mfd: maxim,max77693: Add USB connector"
      commit: c7f5bd9f3aa04a5d0ced8c8f7835bead62380fa6

--
Lee Jones [李琼斯]

