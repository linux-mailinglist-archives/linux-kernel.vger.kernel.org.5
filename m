Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655F7F3858
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjKUVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:32:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09812B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:32:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC73C433C7;
        Tue, 21 Nov 2023 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700602335;
        bh=X2pX6zjIezmOphz2fsepwof1up+Wj7drUJ9WUWnm88s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QfTakCdQV8fvOFgAXcIyUOQDs2rJgK2uOSKu59J3XdHZ2v2BCwE10Nyfc+vv8aalL
         7K3Ok6GSc6zNsvLmOLMRYi3ur5ch5bduBBWpcGHd6BAit8h0XdQo1VB5xCmKjiViEY
         KMxirtK1cKoJaLO+fkC4jTlZGU16LmuKN3jla02bswEb3F/k9JH9zfpXrrLmycnGKn
         urKheLGBEKFmGXyxhVbQVS3TtWCSBB9bb3VbFq53B037iLlzAQlkI+9Sh5uJE0Lh9o
         pekgOsGoM2ML7SzaLyWYUudKG+uI5pCfqx9nmdxtKoSL69Kur+83dlGm0qQ2/51j5D
         2VXyhh0KFGNUA==
Date:   Tue, 21 Nov 2023 15:32:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Message-ID: <20231121213213.GA258296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad43c202-3796-469c-b7fb-7591026e6888@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:52:21AM +0800, Minda Chen wrote:
> ...
> BTW. Could you give any comments to Refactoring patches (patch 2 -
> patch 16)and PLDA patch(patch 17) next week?  Thanks.

I think Krzysztof or Lorenzo will handle these.  I skimmed them and
didn't see any major problems.

Bjorn
