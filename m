Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E977A731
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHMO4K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Aug 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjHMO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:56:08 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFD10E5;
        Sun, 13 Aug 2023 07:56:08 -0700 (PDT)
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 49397201E8;
        Sun, 13 Aug 2023 16:56:04 +0200 (CEST)
Date:   Sun, 13 Aug 2023 16:56:02 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     kernel test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     oe-kbuild-all@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: Add DSI display support
User-Agent: K-9 Mail for Android
In-Reply-To: <202308132205.nYgQd2fC-lkp@intel.com>
References: <20230812191123.14779-1-francesco@dolcini.it> <202308132205.nYgQd2fC-lkp@intel.com>
Message-ID: <6619F245-19FA-456F-98AA-302AAF69383D@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Il 13 agosto 2023 16:45:11 CEST, kernel test robot <lkp@intel.com> ha scritto:
>Hi Francesco,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on robh/for-next]
>[also build test ERROR on linus/master v6.5-rc5 next-20230809]
>[If your patch is applied to the wrong git tree, kindly drop us a note.

here the note, wrong tree.

>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]

yep, gonna remember about this next time...

