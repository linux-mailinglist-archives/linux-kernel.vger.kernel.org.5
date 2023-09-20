Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7CD7A7872
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjITKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjITKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:01:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01B08F;
        Wed, 20 Sep 2023 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695204087; x=1726740087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhGYfJjGh/XnmWB/G+1RMEq82v8g0lovgNTL7upK1Pc=;
  b=UlTRH+2gYNxP9Ttzeql+giZrHCqUzEDPeYOurwAyFIQXgYqC8zdHHz5t
   w/QdIw46Pk/OSvyp8pIkmNcLFrGkDr/a8IuppSEhwLavC8UitkKbik10+
   zmcMQBROEvNkAvF00eCBlfoWhvzSfSCLXxuXdYM4wPoMLvaRThMrcCwai
   VJlZzx4h1GOATs5mi2Wdcl9LBR9LgwqYf8o2dXTvdMzKenCBZtGxnXevy
   dnSbvZ9XcDTbJWZJClXM7rXZmbYyL7gKTa0JkNkyjnoywkDBlk1PBJWSE
   iSDSrnbNOVlxp2695Iar82qPBUBdvyM/fxE2kHKkPVxm2/j2opWy4G44U
   w==;
X-CSE-ConnectionGUID: R+NA1OHjSiydIprkI9bNjQ==
X-CSE-MsgGUID: ujjYxhtJQdi9rsEYxZFB0w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5625564"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 03:01:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 03:01:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 03:01:22 -0700
Date:   Wed, 20 Sep 2023 11:01:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Wang <unicornxw@gmail.com>
CC:     <aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <emil.renner.berthing@canonical.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 00/11] Add Milk-V Pioneer RISC-V board support
Message-ID: <20230920-muppet-wad-ee76f3112651@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxKIZ4cRRsBMAedi"
Content-Disposition: inline
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wxKIZ4cRRsBMAedi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2023 at 02:33:48PM +0800, Chen Wang wrote:
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
> in a standard mATX form factor. Add minimal device
> tree files for the SG2042 SOC and the Milk-V Pioneer board.

Please run dtbs_check with W=1 set & fix the below issues:

sg2042-cpus.dtsi:1600.25-1607.5: Warning (unit_address_vs_reg): /cpus/l2-cache@0: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1609.25-1616.5: Warning (unit_address_vs_reg): /cpus/l2-cache@1: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1618.25-1625.5: Warning (unit_address_vs_reg): /cpus/l2-cache@2: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1627.25-1634.5: Warning (unit_address_vs_reg): /cpus/l2-cache@3: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1636.25-1643.5: Warning (unit_address_vs_reg): /cpus/l2-cache@4: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1645.25-1652.5: Warning (unit_address_vs_reg): /cpus/l2-cache@5: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1654.25-1661.5: Warning (unit_address_vs_reg): /cpus/l2-cache@6: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1663.25-1670.5: Warning (unit_address_vs_reg): /cpus/l2-cache@7: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1672.25-1679.5: Warning (unit_address_vs_reg): /cpus/l2-cache@8: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1681.25-1688.5: Warning (unit_address_vs_reg): /cpus/l2-cache@9: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1690.27-1697.5: Warning (unit_address_vs_reg): /cpus/l2-cache@10: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1699.27-1706.5: Warning (unit_address_vs_reg): /cpus/l2-cache@11: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1708.27-1715.5: Warning (unit_address_vs_reg): /cpus/l2-cache@12: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1717.27-1724.5: Warning (unit_address_vs_reg): /cpus/l2-cache@13: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1726.27-1733.5: Warning (unit_address_vs_reg): /cpus/l2-cache@14: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:1735.27-1742.5: Warning (unit_address_vs_reg): /cpus/l2-cache@15: node has a unit name, but no reg or ranges property
sg2042-cpus.dtsi:256.15-275.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@0: duplicate unit-address (also used in node /cpus/l2-cache@0)
sg2042-cpus.dtsi:277.15-296.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@1: duplicate unit-address (also used in node /cpus/l2-cache@1)
sg2042-cpus.dtsi:298.15-317.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@2: duplicate unit-address (also used in node /cpus/l2-cache@2)
sg2042-cpus.dtsi:319.15-338.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@3: duplicate unit-address (also used in node /cpus/l2-cache@3)
sg2042-cpus.dtsi:340.15-359.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@4: duplicate unit-address (also used in node /cpus/l2-cache@4)
sg2042-cpus.dtsi:361.15-380.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@5: duplicate unit-address (also used in node /cpus/l2-cache@5)
sg2042-cpus.dtsi:382.15-401.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@6: duplicate unit-address (also used in node /cpus/l2-cache@6)
sg2042-cpus.dtsi:403.15-422.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@7: duplicate unit-address (also used in node /cpus/l2-cache@7)
sg2042-cpus.dtsi:424.15-443.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@8: duplicate unit-address (also used in node /cpus/l2-cache@8)
sg2042-cpus.dtsi:445.15-464.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@9: duplicate unit-address (also used in node /cpus/l2-cache@9)
sg2042-cpus.dtsi:466.17-485.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@10: duplicate unit-address (also used in node /cpus/l2-cache@10)
sg2042-cpus.dtsi:487.17-506.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@11: duplicate unit-address (also used in node /cpus/l2-cache@11)
sg2042-cpus.dtsi:508.17-527.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@12: duplicate unit-address (also used in node /cpus/l2-cache@12)
sg2042-cpus.dtsi:529.17-548.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@13: duplicate unit-address (also used in node /cpus/l2-cache@13)
sg2042-cpus.dtsi:550.17-569.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@14: duplicate unit-address (also used in node /cpus/l2-cache@14)
sg2042-cpus.dtsi:571.17-590.5: Warning (unique_unit_address_if_enabled): /cpus/cpu@15: duplicate unit-address (also used in node /cpus/l2-cache@15)

Thanks,
Conor.

--wxKIZ4cRRsBMAedi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQrC4QAKCRB4tDGHoIJi
0n49AP9Q2yOtEngC/IQEoTH7b+/RHwQ0bnUPOAVp+7LQiuslVwD/XwFBGvnj86pP
Txdr/b4hjIbPplTAAS+HgxEBIDyQzQY=
=6fL7
-----END PGP SIGNATURE-----

--wxKIZ4cRRsBMAedi--
