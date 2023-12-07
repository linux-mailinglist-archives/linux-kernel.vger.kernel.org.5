Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7180886C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379370AbjLGMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbjLGMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:44:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A979811F;
        Thu,  7 Dec 2023 04:44:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVl4Jpgz4xKl;
        Thu,  7 Dec 2023 23:44:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, Zhao Ke <ke.zhao@shingroup.cn>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shenghui.qu@shingroup.cn,
        luming.yu@shingroup.cn, dawei.li@shingroup.cn
In-Reply-To: <20231129075845.57976-1-ke.zhao@shingroup.cn>
References: <20231129075845.57976-1-ke.zhao@shingroup.cn>
Subject: Re: [PATCH v2] powerpc: Add PVN support for HeXin C2000 processor
Message-Id: <170195271167.2310221.14120518840277202418.b4-ty@ellerman.id.au>
Date:   Thu, 07 Dec 2023 23:38:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 15:58:45 +0800, Zhao Ke wrote:
> HeXin Tech Co. has applied for a new PVN from the OpenPower Community
> for its new processor C2000. The OpenPower has assigned a new PVN
> and this newly assigned PVN is 0x0066, add pvr register related
> support for this PVN.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Add PVN support for HeXin C2000 processor
      https://git.kernel.org/powerpc/c/e12d8e2602d2bcd26022eff3e2519d25925e760c

cheers
