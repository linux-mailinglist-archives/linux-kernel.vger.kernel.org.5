Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6106576D775
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjHBTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHBTJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F2326AE;
        Wed,  2 Aug 2023 12:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA7461A73;
        Wed,  2 Aug 2023 19:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A35C433C7;
        Wed,  2 Aug 2023 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691003378;
        bh=YKlsStj3ezOkt0RWaJXuZ7tqMra0EQULwTm0YtT1O1I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BxoOGEVgCqbAnkuVPG4r70PXFYVmKk+LgZKjejuZD+9XmICZoqz+vPYJLel0E1B6o
         q2mW1hNKaAIYNwWyrxVYTzK7rcU09oDYKY2+ZmvszEHpiBNjgQ764DuCtTqngdvIDu
         JcOID4UUx5AYHu7cZ6qE2Ru4slL1l6zWldrGtIBLXnBU69uYZLRAYIo4FBoHHgdFpl
         LFA3Ac1Y74LrcMQcnYBnUqpuSYXOeopyFnmvtSyR8hxTB0i1XGEwXXa4UsG8vVPcEb
         H2v9KUBhuDO1Mf8/6XRLs2Z5HH2H/5U5mEpke4BBwEz7vE7ynvv8UAxKKsnNz6prd/
         l7VLa+dsQ9gBw==
Message-ID: <ccd0ea6c0c0165490279a357745b0f71.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230728165923.108589-1-krzysztof.kozlowski@linaro.org>
References: <20230728165923.108589-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: xlnx,versal-clk: drop select:false
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 12:09:36 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-07-28 09:59:23)
> select:false makes the schema basically ignored and not effective, which
> is clearly not what we want for a device binding.
>=20
> Fixes: 352546805a44 ("dt-bindings: clock: Add bindings for versal clock d=
river")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Applied to clk-next
