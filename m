Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283967FA7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjK0Rcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjK0Rcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:32:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133DD51
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:32:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F028CC433C7;
        Mon, 27 Nov 2023 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701106377;
        bh=BgbaDnMC2tbzXy23qRFkhrncnNLb4XGkV4S41F/p7Yo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DXI7RxKKeHC0GXYGmZOGMuRiMzmNk9RZRAk9d6TgCRObIqhjmUKxd7gpN9k7M15C6
         BPzw40RPJFMcJeMtdcbsa0yuQTewyQVevXDa88g95ZwmFlqabn9uk2nkWA26ALdEOz
         QSrvkAgaJVIHtFw3E1X4kpmAUQMdy+l9Qvui2ArtIPxgcc/6WEv8lRAXbUHD0E2gIc
         aXRSzPbd+ltAAmFemcwCSxQJsj5kH1BChAxnwpKAta+d3AUMERGy55J6Jl8pdQcyME
         JF3FG4ZxnUykx2HLRGmqbPeWFlt8V9xyPNUUnt/WN62CPMKOLuo+ercwqq3n4VfIhR
         vnWXMyo3dhZfQ==
Message-ID: <b711a36c58455deeef5e1caa6669f546.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Date:   Mon, 27 Nov 2023 09:32:54 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-11-24 01:21:21)
> Use only one and exactly one space around '=3D' in DTS example.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
