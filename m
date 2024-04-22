Return-Path: <linux-kernel+bounces-153483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AC8ACE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CB91F21F67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05AB1509A6;
	Mon, 22 Apr 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [165.204.184.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637A15099A;
	Mon, 22 Apr 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.184.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793520; cv=none; b=BdK+VNIJ5qKzRmLx4bZspQoNg5JaGvZw9y5CUskoLoJxwO33MHuV+abvAdH4rSzU6EUBxz2mWJnkL2fzM12PxNWh6KKs3ufpSKFb+PChJ93cnkSMex8TPWgH1Eju9SengKFMuMjPNGn+r/ab63YyC3EJmToA5XSvTsqwCzsNfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793520; c=relaxed/simple;
	bh=KJtLJ1PiXTSiUhXEI+u8c8gH/+X5sjYmBdrsu7oo7NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1BV4IuUGMrTJR+HTLPA7Q9Pe0kjcsIUpf/8y0o5Ll+GNU5j8zcFw0JRjVDAkpaeCUQFiHpZjEhyDio5490h3hlOte+94Ur+mNkCdlTUz5Pg/MCsMGI6y80/+SRxf1YKCKhcfr6hU7nKfCODO2weIHeb1EHqfml/7nffRR/symI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=165.204.184.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 1A8EC137EF; Mon, 22 Apr 2024 08:37:31 -0500 (CDT)
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: corbet@lwn.net,
	elena.reshetova@intel.com
Cc: cabilbao@amd.com,
	bilbao@vt.edu,
	avadhut.naik@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/MAINTAINERS: Update my email address
Date: Mon, 22 Apr 2024 08:37:23 -0500
Message-ID: <20240422133726.129074-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the near future, I will not have access to the email address I used as
maintainer of a number of things, mostly in the documentation. Update that
address to my personal email address (see Link) so I can continue
contributing.

Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/security/snp-tdx-threat-model.rst           | 2 +-
 Documentation/translations/sp_SP/index.rst                | 2 +-
 Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
 .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
 .../translations/sp_SP/process/email-clients.rst          | 2 +-
 Documentation/translations/sp_SP/process/howto.rst        | 2 +-
 Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
 .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
 Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
 .../translations/sp_SP/process/programming-language.rst   | 2 +-
 .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
 MAINTAINERS                                               | 8 ++++----
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/security/snp-tdx-threat-model.rst b/Documentation/security/snp-tdx-threat-model.rst
index ec66f2ed80c9..3a2d41d2e645 100644
--- a/Documentation/security/snp-tdx-threat-model.rst
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -4,7 +4,7 @@ Confidential Computing in Linux for x86 virtualization
 
 .. contents:: :local:
 
-By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 Motivation
 ==========
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index c543b495c042..274ef4ad96b9 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -7,7 +7,7 @@ Traducción al español
 
 	\kerneldocCJKoff
 
-:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+:maintainer: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_disclaimer:
 
diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Documentation/translations/sp_SP/memory-barriers.txt
index 27097a808c88..153e57130775 100644
--- a/Documentation/translations/sp_SP/memory-barriers.txt
+++ b/Documentation/translations/sp_SP/memory-barriers.txt
@@ -1,6 +1,6 @@
 NOTE:
 This is a version of Documentation/memory-barriers.txt translated into
-Spanish by Carlos Bilbao <carlos.bilbao@amd.com>. If you find any
+Spanish by Carlos Bilbao <carlos.bilbao.osdev@gmail.com>. If you find any
 difference between this document and the original file or a problem with
 the translation, please contact the maintainer of this file. Please also
 note that the purpose of this file is to be easier to read for non English
@@ -18,7 +18,7 @@ Documento original: David Howells <dhowells@redhat.com>
     Will Deacon <will.deacon@arm.com>
     Peter Zijlstra <peterz@infradead.org>
 
-Traducido por: Carlos Bilbao <carlos.bilbao@amd.com>
+Traducido por: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 Nota: Si tiene alguna duda sobre la exactitud del contenido de esta
 traducción, la única referencia válida es la documentación oficial en
 inglés.
diff --git a/Documentation/translations/sp_SP/process/code-of-conduct.rst b/Documentation/translations/sp_SP/process/code-of-conduct.rst
index adc6c770cc37..a6c08613aefc 100644
--- a/Documentation/translations/sp_SP/process/code-of-conduct.rst
+++ b/Documentation/translations/sp_SP/process/code-of-conduct.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
-:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_code_of_conduct:
 
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index a37274764371..b5a84df44cea 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/coding-style.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_codingstyle:
 
diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
index fdf1e51b84e4..55d5803daf41 100644
--- a/Documentation/translations/sp_SP/process/email-clients.rst
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_email_clients:
 
diff --git a/Documentation/translations/sp_SP/process/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
index dd793c0f8574..72ea855ac9dc 100644
--- a/Documentation/translations/sp_SP/process/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/howto.rst <process_howto>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_howto:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-docs.rst b/Documentation/translations/sp_SP/process/kernel-docs.rst
index 2f9b3df8f8fa..a62c6854f59b 100644
--- a/Documentation/translations/sp_SP/process/kernel-docs.rst
+++ b/Documentation/translations/sp_SP/process/kernel-docs.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_kernel_docs:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
index d66902694089..d47a1c154610 100644
--- a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_statement_kernel:
 
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index 7c7dfb4ba80b..32a99aac2f6c 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_magicnumbers:
 
diff --git a/Documentation/translations/sp_SP/process/programming-language.rst b/Documentation/translations/sp_SP/process/programming-language.rst
index 301f525372d8..ba2164057f45 100644
--- a/Documentation/translations/sp_SP/process/programming-language.rst
+++ b/Documentation/translations/sp_SP/process/programming-language.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_programming_language:
 
diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index c2757d9ab216..18bb3413c3ca 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_submittingpatches:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d818866d6d73..8e9c2fd7a8a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -987,7 +987,7 @@ F:	drivers/video/fbdev/geode/
 
 AMD HSMP DRIVER
 M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
-R:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/arch/x86/amd_hsmp.rst
@@ -5325,7 +5325,7 @@ F:	drivers/usb/atm/cxacru.c
 
 CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
 M:	Elena Reshetova <elena.reshetova@intel.com>
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/security/snp-tdx-threat-model.rst
 
@@ -10549,7 +10549,7 @@ S:	Orphan
 F:	drivers/video/fbdev/imsttfb.c
 
 INDEX OF FURTHER KERNEL DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
@@ -20549,7 +20549,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
 SPANISH DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 R:	Avadhut Naik <avadhut.naik@amd.com>
 S:	Maintained
 F:	Documentation/translations/sp_SP/
-- 
2.41.0


