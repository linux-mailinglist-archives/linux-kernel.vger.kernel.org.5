Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D848F78494D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHVSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHVSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10811F;
        Tue, 22 Aug 2023 11:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C5765B0C;
        Tue, 22 Aug 2023 18:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8737C433C8;
        Tue, 22 Aug 2023 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692728086;
        bh=bT544UBRGcCu3KciRnWuvQZJPAko+oTrWuhgYPYj+wM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lT109YoDvDGnN1g1hZVQsIGE2ONBzVw1+Oqj6DV28+VcqpoyBETL3aot22bxUb2KF
         UhSwoSVSsIiLiksKlkRnAsZ6rFEFH6yMwBtA/LfEK6R/0otkDGdHzYn7N+PSxIOfWY
         moYSbVdgrVo0j6LS2oYFIeAy3SG6LFouDHREkqukF3+paZQxfrn6xEGC2YToAmKF3T
         Qv+Ovp0gPtsxwvlJIGdvdfa0t2xEDxrIA8//4IzqC9as0CR8d+frgHAN+sNCC7392N
         jzSdnz6emR4kVVXlOufCM0DHRIvynzRIArYptsLCFYuVTtXjEftUFEHdbXO38D7zbz
         KiqEJS2GWKZLg==
Message-ID: <20d97115695c13341e8f66db1c90f9af.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230820073429.9069-1-krzysztof.kozlowski@linaro.org>
References: <20230820073429.9069-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.6
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 22 Aug 2023 11:14:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-08-20 00:34:29)
> Hi,
>=20
> Few commits for Samsung clock drivers.
>=20
> Best regards,
> Krzysztof
>=20
>=20
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaa=
a5:
>=20
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.6
>=20
> for you to fetch changes up to b3f9581affb03ed28ff1905b649e66904f29b9e4:
>=20
>   dt-bindings: clock: samsung: remove define with number of clocks (2023-=
08-15 07:50:15 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
