Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4077D01F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjHOQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjHOQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167F1999;
        Tue, 15 Aug 2023 09:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AF565BE3;
        Tue, 15 Aug 2023 16:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AC7C433C7;
        Tue, 15 Aug 2023 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692116972;
        bh=LKI52qu5YBizA18cb57HmGDQiAUsDp91kpcEQdHzraY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV5EzQcDpmN2hdz2XjMFQMAphqVL2zzdv/qIL8DZYuPbtPTdPMc72F/gi7w86tv8Q
         jf07zRDlDhkfbwoV21soHOLdzXzVYsSTFiLNXgLkDGTiVQFIIKDb5lD2OpeGZeBdzS
         r2wfohf0Z7hyWmWVzsPsuYypPWkTbcA43UyrN6D36no99ytFld9qJ6q7OmOVPUe5uT
         wVmEDC/xKRzg1xOQeGcZdi7E7c/POjRuBm3gWz8K0Z2/HvVumZZjbz9jgolLU5FzOk
         foLSXuBN6mC7oaZ6Kqw1jpWwPqfcykE+S6Nuu5aFtIOKqbXHbkfHb6Z1foL2JJ8kKu
         UR3tKD29USwsw==
Date:   Tue, 15 Aug 2023 09:32:16 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/5] phy: qcom: Introduce M31 USB PHY driver
Message-ID: <jkkamkixp7u2js7lvr3thfb4nbslevbymksvbfudblpci7wr32@jxmjl64y6yl7>
References: <cover.1691999761.git.quic_varada@quicinc.com>
 <c8821bb0124a54cc774a2ff7b9c40df28eb7711e.1691999761.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8821bb0124a54cc774a2ff7b9c40df28eb7711e.1691999761.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:36:02PM +0530, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver for the USB M31 PHY
> (https://www.m31tech.com) found in Qualcomm IPQ5018, IPQ5332
> SoCs.
> 

Thanks, this looks good to me now.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
