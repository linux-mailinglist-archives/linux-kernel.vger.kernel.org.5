Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C67D574F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjJXQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJXQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:04:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530210C3;
        Tue, 24 Oct 2023 09:04:22 -0700 (PDT)
Received: from smtpclient.apple (unknown [IPv6:2804:14d:72b4:852d:c576:6f5c:b40c:8bc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD54E6607333;
        Tue, 24 Oct 2023 17:04:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698163461;
        bh=+Vh/hKXSMxVemoTaDD6PmHLJ81Y8GMrZHh8c46r18eQ=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=D6rOUCWGuj4x9qFyNZnYwmqSwxpaXr6VoIpTJo/MLN8SPpU+EemZjcP9srUNnxUN6
         ZOUNMWDgcvr/XbxwiYch7X4pahcnTBfmDjuv1LzB83AlIiipXhan8maEi6wXASwzPI
         bHaAXetAzriSy/rTKLwZZ7RJXrKYttAs8Y+331L9RfvN+/stVfdx5DP4f6WCpOeIdi
         TiOoJJH2KPkVsqn5DR2Ilcew+WB3bG4CpSap8EYsiyIWJohip4N/tnk9Eiz0fSLU4G
         DBRprk2H2jpBoaQVsOxhO60TfI1Ooe24iL4SYuMNF6pF4YonAaPkbYYRilowlvT8d+
         SC1VNfdOgmfjA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/5] visl: Adapt output frames for reference comparison
From:   Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20231023185850.67082-1-detlev.casanova@collabora.com>
Date:   Tue, 24 Oct 2023 13:04:04 -0300
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F72FD9D-15D3-4087-8113-B5EE6F7CF825@collabora.com>
References: <20231023185850.67082-1-detlev.casanova@collabora.com>
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

Hi Detlev. This series look good to me.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=20

=E2=80=94Daniel=
