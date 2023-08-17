Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB977F2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbjHQJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349312AbjHQJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7530E3;
        Thu, 17 Aug 2023 02:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D440664644;
        Thu, 17 Aug 2023 09:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40050C433C7;
        Thu, 17 Aug 2023 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692263069;
        bh=Fh6KfWzZw6QoOPB0FqYFgxdVtiqrmKrkkZqlj+4LsoE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HJE3CR4JxgUIUPzsqCZH+s93eGszmEjc6iLjZUuHSXE1/CSIXNLDZFhi+PS/+WtBs
         /Kv6PXSHtRmLiAKfKpuEGIXov1k/mk3+c0PkTgZ1j6P9b568x8C5YZO/3aURGOslgk
         y5IPpBld32yapWHe/avHx5aPjGxUu1Df4PdbyJTJXLEkvrMXZTP92KYAlS7XnhfGTf
         KAzunhLk2Eqa9eXc371sVz119jYXJG3R110Jo0vi9anVUbW936gnHZ4SI3+6FGoMFz
         ubZZl0Crzar3Dj1v87VzjqZsFKcZGKF+2prANYOktjUKCSu2UlNuKtFrcDVsi30H+o
         0WREh2odeqIzg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20230728102529.266030-1-varshini.rajendran@microchip.com>
References: <20230728102529.266030-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 15/50] dt-bindings: atmel-gpbr: add
 microchip,sam9x7-gpbr
Message-Id: <169226306696.928678.2345448260460546641.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:04:26 +0100
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

On Fri, 28 Jul 2023 15:55:29 +0530, Varshini Rajendran wrote:
> Add microchip,sam9x7-gpbr to DT bindings documentation.
> 
> 

Applied, thanks!

[15/50] dt-bindings: atmel-gpbr: add microchip,sam9x7-gpbr
        commit: d9a9adb39e7a2448b925366cd301ce8a9e2c4bee

--
Lee Jones [李琼斯]

