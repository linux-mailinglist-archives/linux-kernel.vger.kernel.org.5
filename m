Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5540177A515
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHMGRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:17:08 -0400
Received: from out-112.mta1.migadu.com (out-112.mta1.migadu.com [IPv6:2001:41d0:203:375::70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78C1703
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:17:08 -0700 (PDT)
Date:   Sun, 13 Aug 2023 16:16:40 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691907425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGW+uEtQIIiysgEl4d9oH5pQEw9oqmQWs9ZMkCRYRdg=;
        b=tYs+F4/7NlUNIjNBlMNFZeFTyU4zkuLFdyt1mSh2AcPir3KGnaEsZ86DOtOF7rfyRUEyo4
        JCue7/Tc1C6asomXlKZ5uR4db7svbba65M8FgzmnkXWTZCe+qVhTkprcepOVrwkpUQN0jw
        Ee1m/redEKiHt7mql3UekWoqKKo/pCaApbHC2Vue81crqfEbhP6LWCXHssm6EG427x7KWx
        bmc1fwoOYIqxqdgjAY0kfx5ZD62AQLhELM1nVrHBmLBQnkDzDvek5Vbpbp5HT/clHJj26o
        i8K0tx1pQQzpwmeOP9cLBN7fAbwBLlqAj7b6jMN8huaTC2LNWncN7Fl0Bzj4uQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
Message-ID: <ZNh1SJakNFqPLrwa@titan>
References: <20230807191952.2019208-1-contact@jookia.org>
 <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
 <ZNhau0j_tV3EXGxl@titan>
 <CAGb2v647FoATnjk43GKqVihX-FtZN+7XrxMMRseuqap0MBg2FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v647FoATnjk43GKqVihX-FtZN+7XrxMMRseuqap0MBg2FQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 02:14:42PM +0800, Chen-Yu Tsai wrote:
> Applied. Please check here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=sunxi/dt-for-6.6&id=f05af44f691351bfd954f39ec376666dc5e1b869

Looks good to me. Thank you.
