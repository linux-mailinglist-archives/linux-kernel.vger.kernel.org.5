Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A067A9714
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjIURLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjIURKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863C7693;
        Thu, 21 Sep 2023 10:05:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvj0M5wz4xPc;
        Thu, 21 Sep 2023 19:33:21 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     alsa-devel@alsa-project.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 00/11] add missing of_node_put
Message-Id: <169528860030.876432.17353767421208248949.b4-ty@ellerman.id.au>
Date:   Thu, 21 Sep 2023 19:30:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 11:55:10 +0200, Julia Lawall wrote:
> Add of_node_put on a break out of an of_node loop.
> 

Patches 3 and 6 applied to powerpc/next.

[03/11] powerpc/powermac: add missing of_node_put
        https://git.kernel.org/powerpc/c/a59e9eb25216eb1dc99e14fc31b76aa648d79540
[06/11] powerpc/kexec_file: add missing of_node_put
        https://git.kernel.org/powerpc/c/06b627c1236216ac1239c5e1afcc75359af3fb72

cheers
