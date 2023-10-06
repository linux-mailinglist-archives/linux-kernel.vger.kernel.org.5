Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D47BB65B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJFLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjJFLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:21:21 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A8F10D;
        Fri,  6 Oct 2023 04:21:16 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 9a1c822740487185; Fri, 6 Oct 2023 13:21:15 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8DA8A665D0E;
        Fri,  6 Oct 2023 13:21:14 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1] thermal: Remove Amit Kucheria from MAINTAINERS
Date:   Fri, 06 Oct 2023 13:21:14 +0200
Message-ID: <5716404.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefvddtfeffveeguefgtdeiuddtieelheegkefhhefgkeefuddutdehgfdvudduieenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Amit Kucheria has not been participating in kernel development in any
way or form for quite some time, so it is not useful to list him as a
designated reviewer for the thermal subsystem or as the maintainer of
the thermal zone device bindings.

Remove him from those two places accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml |    3 ---
 MAINTAINERS                                                  |    1 -
 2 files changed, 4 deletions(-)

Index: linux-pm/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
===================================================================
--- linux-pm.orig/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ linux-pm/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -7,9 +7,6 @@ $schema: http://devicetree.org/meta-sche
 
 title: Thermal zone
 
-maintainers:
-  - Amit Kucheria <amitk@kernel.org>
-
 description: |
   Thermal management is achieved in devicetree by describing the sensor hardware
   and the software abstraction of cooling devices and thermal zones required to
Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -21363,7 +21363,6 @@ F:	drivers/media/radio/radio-raremono.c
 THERMAL
 M:	Rafael J. Wysocki <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
-R:	Amit Kucheria <amitk@kernel.org>
 R:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported



