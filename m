Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756F780F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378023AbjHRPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbjHRPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069C4683;
        Fri, 18 Aug 2023 08:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC2F67D88;
        Fri, 18 Aug 2023 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C62EC433C8;
        Fri, 18 Aug 2023 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692372294;
        bh=Du9xMGCbMpqgDA/Bdatj5Aohin2SHmVqvY9fkZp8nGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+AcV8w5sotIt+OsLf+UftXp8ZR/iqYMLtEPVR68iXluEourAtzWhMY6TGTlHHno+
         hkXpxfjj8d2wXMZxGKUUawiwdp9TTY0tTtcBr4lMFWyHzcD/XT2BUzMVdJpAxSRVH8
         ymh1/tUiHA8w6/RFLP/aqqw9V/vf2JG7ay6FK5uZADK55NqJlHXMQhCWBst+NMszxI
         LHkAKIyJJ7dgQW00qgJM/hX8llyz3Vj5jaSGuUQGzwXLnlNLT2Goj9NsHZU5Xp181h
         4lvkK60spcbf27u6KjCRqxb9OMqzZs/tJ1TAJxKJunnE3nQtlWOCK7iX4/9Y1WToCZ
         iw72ZZo0aBNeQ==
Received: (nullmailer pid 4177957 invoked by uid 1000);
        Fri, 18 Aug 2023 15:24:52 -0000
Date:   Fri, 18 Aug 2023 10:24:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Cc:     dlemoal@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        michal.simek@amd.com, krzysztof.kozlowski+dt@linaro.org,
        nava.kishore.manne@amd.com, sebastian.reichel@collabora.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        jassisinghbrar@gmail.com
Subject: Re: [PATCH] dt-bindings: power: xilinx: merge zynqmp-genpd.txt with
 firmware binding
Message-ID: <169237229130.4177904.9922268244227130264.robh@kernel.org>
References: <20230816130309.1338446-1-naman.trivedimanojbhai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816130309.1338446-1-naman.trivedimanojbhai@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 06:03:09 -0700, Naman Trivedi Manojbhai wrote:
> Remove the zynqmp-genpd.txt binding. Add the power-domain-cells
> property from the zynqmp-genpd.txt binding to firmware binding.
> 
> Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 14 ++++++++
>  .../bindings/power/xlnx,zynqmp-genpd.txt      | 34 -------------------
>  2 files changed, 14 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
> 

Applied, thanks!

