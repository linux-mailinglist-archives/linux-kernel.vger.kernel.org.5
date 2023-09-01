Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E19790181
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbjIARcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjIARca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:32:30 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289261BF;
        Fri,  1 Sep 2023 10:32:28 -0700 (PDT)
Date:   Fri, 01 Sep 2023 17:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693589543; x=1693848743;
        bh=L8iFCrByehdP32Ug8g93P1l8ntl/P1QPuTKAwujEEFs=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=YxZK6P8oLerxBqjVBJWO//jQ/qfl3AjmWpaFZlcB9QrYP3B9TBTLtXeGjET04MzGf
         +RiZ8VO0l+j5Rp0wqOIFDgTSaF5sr8YQdDTP+a+wcX65roOUKzfwGi1y58VJNtZbwb
         1y16d8cUO1Y3fsygzStnGiyNt9kqIXR2sT7ifzv6A+ZZxTinnfQBA6M0iMphTq4ZzJ
         5FTC+WwDF/y7G+C2duP92HFV3gORmg+8nCN5mIgDEFKy7dYqxrUjCZFhVHO7iR88ae
         U3GJs3/ykoFz9Wv9Xvec8asHRef+mYz198FSjahvsCAkPJfxGPPamvKhu8aVHB09nN
         pOt5IgMrw+2nQ==
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Announce loop-AES-v3.8b file/swap crypto package
Message-ID: <Yp0copsUXPykv4ZDXp_eXkzuLDR_t16fVudIpIOmhZ5AJ-LNmqBlUwHpFJ_IEaCxJiQb_rLHQbS6XkLiM8eT-2SPDE9ymdItgvs5MTlRemA=@protonmail.com>
Feedback-ID: 22639318:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 6.5 kernels.

bzip2 compressed tarball is here:

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8b.tar.bz2
    md5sum 310d1f45e45f24e7303b337e31584510

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8b.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

