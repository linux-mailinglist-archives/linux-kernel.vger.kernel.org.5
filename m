Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1857D5731
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjJXQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjJXQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:00:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE38C10D1;
        Tue, 24 Oct 2023 09:00:25 -0700 (PDT)
Received: from smtpclient.apple (unknown [177.183.181.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F2676607331;
        Tue, 24 Oct 2023 17:00:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698163224;
        bh=nYEnKd6BQOmoWjqD5pgKOyBq9x6yvt09ASzSVgxYUjk=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=YXH7u2IrWtpyjeZ/CQWnAiw0954Ddy7/9OUvVGqV05tsxaE+02HWuTDa0ZbMCzQdj
         0XvkBlr/uCU/TtGabJmSFVYNjO/89RLGq1491d1V5p6N660Tk4iJF2BpjZ/JMiP5Zw
         HpQsugZ6KJhh8JbLvflUO1m/zhQ/0u8Aih6L0gkPJcE9SZaYWV13hm+QDXjjVIp6qT
         YK2IWVHFI1sESWgnzjpcvW1HStaABQHQtsvxHJLKsy9ja5bE9Tom7vihQX/960+cTm
         4R1NW2DGcyOHLpuVzimpz7t+4/f8ekkUZpNGkm1slimSm6oIot2lTKG7I+9Z9RVsOA
         gncBJgkZdO6uw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 5/5] doc: visl: Document codec_variability parameter
From:   Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20231023185850.67082-6-detlev.casanova@collabora.com>
Date:   Tue, 24 Oct 2023 13:00:07 -0300
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E9F547C-D6F5-40EC-9008-6C3810F1891B@collabora.com>
References: <20231023185850.67082-1-detlev.casanova@collabora.com>
 <20231023185850.67082-6-detlev.casanova@collabora.com>
To:     Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Detlev,

+bool codec_variability;
+module_param(codec_variability, bool, 0644);
+MODULE_PARM_DESC(codec_variability,
+  " add codec specific variability data to generate more unique frames. =
(Only h.265 and hevc)=E2=80=9D);

Typo here: h.265 and HEVC are the same.

=E2=80=94 Daniel=
