Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B77E84BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbjKJUrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 15:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjKJUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:47:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4C1BDD;
        Fri, 10 Nov 2023 12:46:23 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 3EE0266073EF;
        Fri, 10 Nov 2023 20:46:22 +0000 (GMT)
From:   "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <20231030193406.70126-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 10 Nov 2023 20:46:21 +0000
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
To:     "Detlev Casanova" <detlev.casanova@collabora.com>
MIME-Version: 1.0
Message-ID: <6093-654e9680-3-67fa3a80@264835418>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/2] =?utf-8?q?doc=3A?==?utf-8?q?_visl=3A?= Add 
 AV1 support
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Detlev,

This does not apply anymore (media_tree/master -> 2e6bf8ce2af120df033fee1ec42f5e78596f5c44)

As for the changes,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

> Add AV1 information in visl documentation.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/admin-guide/media/visl.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
> index 7d2dc78341c9..64229857c17c 100644
> --- a/Documentation/admin-guide/media/visl.rst
> +++ b/Documentation/admin-guide/media/visl.rst
> @@ -71,6 +71,7 @@ The following codecs are supported:
>  - VP9
>  - H.264
>  - HEVC
> +- AV1
>  
>  visl trace events
>  -----------------
> @@ -79,6 +80,7 @@ The trace events are defined on a per-codec basis, e.g.:
>  .. code-block:: bash
>  
>          $ ls /sys/kernel/debug/tracing/events/ | grep visl
> +        visl_av1_controls
>          visl_fwht_controls
>          visl_h264_controls
>          visl_hevc_controls
> -- 
> 2.41.0
>

