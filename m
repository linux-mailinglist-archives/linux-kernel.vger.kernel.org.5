Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6F7A8A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjITRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:24:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D7A3;
        Wed, 20 Sep 2023 10:23:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0534C433C7;
        Wed, 20 Sep 2023 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695230635;
        bh=c7NnRdLLqP4JhMp2aU5nyGYzM2NmsnHZzQn3yIr5ApQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xi5G09YjlDpDDyhPsC/OefA+5QEgulsTleUWQOCB9fVc6o5bAdxmXiBsWmMb+SzP1
         xehlQYH09CYhFcUKUukPfaWL/Av67OfyWzZj+j2RFfNxUf6iMULmzAmFkHCZMhBfyY
         LHvh7fOppTSruqE4oWIx9mFlNyeSknE9rY2/t2Nxjv12DS9Axdt6aHgGpJNbfI8nKV
         c6qWc0HOurPK3c4ySRJ+snRwsmzZpldGaWcur0hn3psKO7FuJPXbBD2YtI1fxbQVgg
         ZmeW4hCvVDMlQRkn2Os1a3ZJ5LavUkob9wWPmPcl1IWXN+nmwgRfyaOXZxDr2QA2cG
         exUps3Rajub8g==
Date:   Wed, 20 Sep 2023 10:28:02 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Jack Matthews <jm5112356@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] ARM: dts: qcom: add common dt for MSM8x26 Lumias
 along with Nokia Lumia 630
Message-ID: <uiwrduxzbkenkm6iuhdk433h47srzuf7z4kngmfjrlbaeeehea@64casco3bwpr>
References: <20230813152623.64989-1-rayyan@ansari.sh>
 <20230813152623.64989-3-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813152623.64989-3-rayyan@ansari.sh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 04:23:11PM +0100, Rayyan Ansari wrote:
> Add a common device tree for Lumia phones based on the Qualcomm MSM8x26
> family of chipsets.
> 
> Currently supports:
> - Framebuffer
> - Touchscreen
> - Keys
> - Regulators
> - MMC
> - USB
> - UART
> 
> Also add an initial device tree for the Nokia Lumia 630, codenamed
> "moneypenny".
> 
> Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>

I believe you meant "Co-developed-by" here, and it needs to be directly
adjacent to the s-o-b. Can you please update these, and make checkpatch
--strict happy?

Regards,
Bjorn

> Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Co-authored-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
